require 'open-uri'

module FbVideo

  BASE_URL = 'https://graph.facebook.com'
  TOKEN = "access_token=#{ENV['FB_APP_TOKEN']}"

  class Collection
    def initialize(id)
      @id = id
      @url = URI::encode("#{::FbVideo::BASE_URL}/#{id}?fields=posts.limit(5000).fields(source,name,type)&#{::FbVideo::TOKEN}")
    end

    def list
      Rails.cache.fetch("videos/#{@id}", expires_in: 1.hour) do
        get_videos.map do |v|
          {
            source: v['source'],
            name: v['name'],
            id: v['id'],
            ts: v['created_time']
          }
        end
      end
    end

    private
      def json_response
        response = open(@url).read
        JSON.parse(response)
      end

      def get_videos
        json = json_response
        json['posts']['data'].select { |p| p['type'] == 'video' && p['source'] =~ /mp4/ }
      end
  end

  class Item
    def initialize(id)
      @id = id
      @url = URI::encode("#{::FbVideo::BASE_URL}/#{id}?fields=name,created_time,id,source&#{::FbVideo::TOKEN}")
    end

    def get
      Rails.cache.fetch("video/#{@id}", expires_in: 10.minutes) do
        response = open(@url).read
        json = JSON.parse(response)
        json['ts'] = json.delete "created_time"
        json
      end
    end
  end
end
