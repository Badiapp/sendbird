module Sendbird
  class Messaging < Base

    attribute :name, String
    attribute :channel_url, String
    attribute :last_message, String
    attribute :last_message_ts, Integer
    attribute :members, Array
    attribute :created_at, String

    def create

      params = {
        name: name
      }

      json = client.post("#{path}", params)

      json["channel_url"] = json["channel"]["channel_url"]

      self.class.new(json)
    end

    def invite(users)
      users = Array(users)

      params = {
        channel_url: channel_url,
        user_ids: users.map(&:id)
      }

      json = client.post("#{path}", params)

      self
    end

    def view

      params = {
        channel_url: channel_url
      }

      json = client.post("#{path}", params)

      json["members"].each do |member|
        member["user_id"] = member["id"]
        member["nickame"] = member["name"]
      end

      self.class.new(json)
    end

    private

      def path
        "v3/messages"
      end

      def reference_id
        channel_url
      end

      def params

      end

  end
end
