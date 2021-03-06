module Sendbird
  class GroupChannel < Base
    attribute :name, String
    attribute :cover_url, String
    attribute :data, String
    attribute :user_ids, String
    attribute :is_distinct, Boolean
    attribute :custom_type, String

    def create
      client.post("#{path}", params)
    end

    # def invite(users)
    #   users = Array(users)
    #
    #   params = {
    #     channel_url: channel_url,
    #     user_ids: users.map(&:id)
    #   }
    #
    #   json = client.post("#{path}/invite", params)
    #
    #   self
    # end

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
        "v3/group_channels"
      end

      def reference_id
        channel_url
      end

      def params
        {
          name: name,
          cover_url: cover_url,
          data: data,
          user_ids: user_ids,
          is_distinct: is_distinct,
          custom_type: custom_type
        }
      end
  end
end
