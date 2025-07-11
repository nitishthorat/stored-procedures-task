from fastapi import FastAPI, WebSocket, BackgroundTasks, HTTPException
from pydantic import BaseModel
import mysql.connector
from mysql.connector import Error
from datetime import datetime
from redis_client import redis_client, channel_name
from ws_manager import manager
import asyncio
from dotenv import load_dotenv
import os

load_dotenv()

app = FastAPI()

db_config = {
    'host': os.getenv('DB_HOST'),
    'user': os.getenv('DB_USER'),
    'password': os.getenv('DB_PASSWORD'),
    'database': os.getenv('DB_NAME')
}

class EmployeeInput(BaseModel):
    name: str
    department: str
    date_of_joining: str
    email: str
    salary: float
    bonus: float

class PostCreate(BaseModel):
    user_id: int
    content: str

async def publish_message(channel: str, message: str):
    await redis_client.publish(channel, message)

@app.websocket("/ws/notifications/{user_id}")
async def websocket_endpoint(websocket: WebSocket, user_id: int):
    await manager.connect(websocket, user_id)
    try:
        pubsub = redis_client.pubsub()
        await pubsub.subscribe(channel_name)
        while True:
            message = await pubsub.get_message(ignore_subscribe_messages=True, timeout=5)
            if message:
                await manager.broadcast(message["data"])
            await asyncio.sleep(0.1)
    except Exception as e:
        print("WebSocket closed:", e)
    finally:
        manager.disconnect(user_id)

@app.post('/employee')
def add_or_update_employee(data: EmployeeInput):
    try: 
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()

        existing_id = None

        # Check if employee exists
        cursor.execute("""
            SELECT id FROM employees
            WHERE name = %s AND department = %s
            LIMIT 1
        """, (data.name, data.department))

        row = cursor.fetchone()

        if row:
            existing_id = row[0]

        if existing_id:
            cursor.execute("""
                UPDATE salary_records
                SET base_salary = %s, bonus = %s, record_created_at = NOW()
                WHERE employee_id = %s
            """, (data.salary, data.bonus, existing_id))

            cursor.execute("""
                INSERT INTO activity_logs(employee_id, action)
                VALUES (%s, %s)
            """, (existing_id, 'Updated salary for existing employee'))
        
        else:
            cursor.execute("""
                INSERT INTO employees(name, department)
                VALUES (%s, %s)
            """, (data.name, data.department))
            new_emp_id = cursor.lastrowid

            cursor.execute("""
                INSERT INTO employee_details(employee_id, date_of_joining, contact_email)
                VALUES (%s, %s, %s)
            """, (new_emp_id, data.date_of_joining, data.email))

            cursor.execute("""
                INSERT INTO salary_records(employee_id, base_salary, bonus)
                VALUES (%s, %s, %s)
            """, (new_emp_id, data.salary, data.bonus))

            cursor.execute("""
                INSERT INTO activity_logs(employee_id, action)
                VALUES (%s, %s)
            """, (new_emp_id, 'New employee added with details and salary'))

        conn.commit()
        return {"message": "Operation completed successfully"}

    except Error as e:
        return {"error": str(e)}

    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

@app.post("/posts")
async def create_post(data: PostCreate, background_tasks: BackgroundTasks):
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()

        # Step 1: Insert the post
        cursor.execute(
            "INSERT INTO posts (user_id, content, created_at) VALUES (%s, %s, %s)",
            (data.user_id, data.content, datetime.now())
        )
        post_id = cursor.lastrowid

        # Step 2: Find all subscribers of the user
        cursor.execute(
            "SELECT subscriber_id FROM subscriptions WHERE publisher_id = %s",
            (data.user_id,)
        )
        subscribers = cursor.fetchall()

        # Step 3: Insert notifications for each subscriber
        notification_message = f"New post from user {data.user_id}: {data.content}"
        for (subscriber_id,) in subscribers:
            cursor.execute(
                "INSERT INTO notifications (subscriber_id, post_id, message, created_at) VALUES (%s, %s, %s, %s)",
                (subscriber_id, post_id, notification_message, datetime.now())
            )

        cursor.execute("SELECT subscriber_id FROM subscriptions WHERE publisher_id = %s", (data.user_id,))
        subscribers = cursor.fetchall()
        message = f"User {data.user_id} posted: {data.content}"

        for (subscriber_id,) in subscribers:
            await manager.send_to_user(subscriber_id, message)

        conn.commit()
        message = f"User {data.user_id} posted: {data.content}"
        # background_tasks.add_task(publish_message, channel_name, message)
        return {"message": "Post created and notification sent."}


    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()



