module Sendbird
  class Client

    def post(url, params = {})
      response = faraday_client.post do |req|
        req.url api_url(url)
        req.headers['Content-Type'] = 'application/json'
        req.headers['Api-Token'] = api_key

        req.body = JSON.generate(params)
      end

      json = JSON.parse response.body

      raise Error, "Error: #{json["message"]}" if json["error"]

      json
    end

    def put(url, params = {})
      response = faraday_client.put do |req|
        req.url api_url(url)
        req.headers['Content-Type'] = 'application/json'
        req.headers['Api-Token'] = api_key

        req.body = JSON.generate(params)
      end

      json = JSON.parse response.body

      raise Error, "Error: #{json["message"]}" if json["error"]

      json
    end


    private

      def faraday_client
        @faraday_client ||= Faraday.new(url: site) do |faraday|
          faraday.request  :url_encoded             # form-encode POST params
          faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        end
      end

      def site
        Sendbird.configuration.site
      end

      def api_key
        Sendbird.configuration.api_key
      end

      def api_url(url)
        "#{url}"
      end

  end
end
