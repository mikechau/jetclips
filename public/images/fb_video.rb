require 'open-uri'

class FbVideo

  BASE_URL = "https://graph.facebook.com/"
  TOKEN = "&access_token=#{ENV['FB_APP_TOKEN']}"

  def initialize(id)
    @url = URI::encode("https://graph.facebook.com/#{id}?fields=posts.limit(5000).fields(source,name,type)&access_token=#{ENV['FB_APP_TOKEN']}")
  end

  def list
    get_videos.map do |v|
      {
        source: v['source'],
        name: v['name'],
        id: v['id'],
        ts: v['created_time']
      }
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