import os
import unittest
import redis


class TestRedis(unittest.TestCase):

    def test_redis(self):
        host = os.getenv('REDIS_PORT_6379_TCP_ADDR')
        port = int(os.getenv('REDIS_PORT_6379_TCP_PORT'))

        pool = redis.ConnectionPool(host=host, port=port, db=0)
        r = redis.Redis(connection_pool=pool)
        r.set('foo', 'bar')


if __name__ == '__main__':
    unittest.main()
