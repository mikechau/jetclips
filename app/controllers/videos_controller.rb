class VideosController < ApplicationController

  before_filter :set_headers
  before_filter :set_http_cache_headers

  caches_action :show, :layout => false, :cache_path => Proc.new { |c| c.params }, :expires_in => 1.hour

  def show
    @videos = FbVideo.new(params[:id])
    render json: @videos.list, layout: false, content_type: 'application/json'
  end


  private
    def set_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
      headers['Access-Control-Request-Method'] = '*'
      headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    end

    def set_http_cache_headers
      expires_in 10.seconds, :public => true
      last_modified = Time.now
      fresh_when last_modified: last_modified , public: true, etag: last_modified
    end

end