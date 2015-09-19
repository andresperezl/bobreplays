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
        render text: "@#{params[:username]} voted for #{@vc.video.title}! (Votes: #{@vc.count})"
      else
        render text: @vc.errors.messages.values[0][0], status: 200
      end
    else
      render nothing: true, status: 200
    end
  end

  def current
    @vp = VideoPlaying.first
    if (@vp.start_time + @vp.video.duration.seconds) < Time.now
      @winner = VoteCount.order(count: :desc).first
      @vp.video = @winner.video
      @vp.start_time = Time.now
      @vp.save
      @winner.last_win_at = Time.now
      @winner.save
      resetCount
    end
  end

  private
    def resetCount
      VoteCount.all.update_all(count: 0)
      Vote.all.destroy
    end
end
