class VideosController < ApplicationController
  before_filter :set_headers

  def index
    videos = FbVideo::Collection.new(params[:id])
    render json: videos.list
  end

  def show
    video = FbVideo::Item.new(params[:id])
    render json: video.get
  end

  private
    def set_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
      headers['Access-Control-Request-Method'] = '*'
      headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    end
end
