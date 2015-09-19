class VideosController < ApplicationController
  def index
    if params[:filter]
      @videos = Video.where("title LIKE ?", "%#{params[:filter]}%").paginate(:page => params[:page])
    else
      @videos = Video.paginate(:page => params[:page])
    end
  end
end
