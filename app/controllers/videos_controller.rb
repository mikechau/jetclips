class VideosController < ApplicationController

  before_filter :set_headers

  caches_action :show, :cache_path => Proc.new { |c| c.params }, :expires_in => 1.hour

  def show
    @videos = FbVideo.new(params[:id])
    render json: @videos.list
  end


  private
    def set_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
      headers['Access-Control-Request-Method'] = '*'
      headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    end

end