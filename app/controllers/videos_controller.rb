class VideosController < ApplicationController
  def index
    if params[:filter]
      filters = params[:filter].split("|").map{ |f| "%#{f.downcase}%" }
      @videos = Video.where("LOWER(title) ILIKE ALL (array[?])", filters).paginate(:page => params[:page])
    else
      @videos = Video.paginate(:page => params[:page])
    end
  end

  def vote
    if params[:key] == Rails.application.secrets.secret_key_base
      @vc = VoteCount.find_or_create_by(video_id: params[:video_id])
      if @vc.vote(params[:username])
        render text: "You (#{params[:username]}) voted for #{@vc.video.title}! (Total votes: #{@vc.count})"
      else
        render text: @vc.errors.messages.values[0][0], status: 400
      end
    else
      render nothing: true, status: 403
    end
  end
end
