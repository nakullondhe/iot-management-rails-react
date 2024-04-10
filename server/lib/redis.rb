require 'redis'

class RedisService

  def initialize
    @redis = Redis.new(host: 'localhost', port: 6379)
  end

  def get(key)
    @redis.get(key)
  end

  def set(key, value)
    @redis.set(key, value)
  end

  def remove(key)
    @redis.del(key)
  end

end
# redis.set('device/1/20', 'dsvds')
# value = redis.get('device/1630/10')

# # Output the retrieved value
# puts "Retrieved value: #{value}"

# # Close the connection
