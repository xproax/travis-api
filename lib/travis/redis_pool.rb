<script src="https://d3tvtfb6518e3e.cloudfront.net/3/opbeat.min.js"
    data-org-id="99fadbe179644906a91f3f6643357dd8"
    data-app-id="9efcf1fb48">
</script>

require 'connection_pool'
require 'redis'
require 'metriks'

module Travis
  class RedisPool
    attr_reader :pool

    def initialize(options = {})
      pool_options = options.delete(:pool) || {}
      pool_options[:size] ||= 10
      pool_options[:timeout] ||= 10
      @pool = ConnectionPool.new(pool_options) do
        ::Redis.new(options)
      end
    end

    def method_missing(name, *args, &block)
      timer = Metriks.timer('redis.pool.wait').time
      @pool.with do |redis|
        timer.stop
        if redis.respond_to?(name)
          Metriks.timer("redis.operations").time do
            redis.send(name, *args, &block)
          end
        else
          super
        end
      end
    end
  end
end
