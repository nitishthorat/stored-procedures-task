import redis.asyncio as redis

redis_client = redis.Redis(host="localhost", port=6379, db=0, decode_responses=True)

channel_name = "new_post_channel"
