module Sendbird
  class User < Base

    attribute :user_id, String
    attribute :nickname, String
    attribute :profile_url, String
    attribute :access_token, String
    attribute :issue_access_token, Boolean

    def create
      client.post("#{path}/", params)
    end

    def update
      client.put("#{path}/#{user_id}", params)
    end

    private

      def path
        "v3/users"
      end

      def reference_id
        user_id
      end

      def params
        {
          user_id: user_id,
          nickname: nickname,
          profile_url: profile_url,
          issue_access_token: issue_access_token
        }
      end
  end
end
