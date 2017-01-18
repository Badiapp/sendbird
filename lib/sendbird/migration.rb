module Sendbird
  class Migration < Base
    attribute :channel_url, String
    attribute :messages, Array

    def create
      client.post("#{path}", params)
    end

    private

      def path
        "v3/migration/#{channel_url}"
      end

      def reference_id
        channel_url
      end

      def params
        {
          messages: messages
        }
      end
  end
end
