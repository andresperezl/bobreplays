class VideosController < ApplicationController
  def index
    #When the filter is defined only show the videos that match the filter
    if params[:filter]
      #Allow multiple matches with the | separator
      filters = params[:filter].split("|").map{ |f| "%#{f.downcase}%" }
      @videos = Video.where("LOWER(title) ILIKE ALL (array[?])", filters).paginate(:page => params[:page])
    else
      @videos = Video.paginate(:page => params[:page])
    end
  end

  def vote
    #Use the secret key so only the Bot can submit the vote and there are no cheaters
    if params[:key] == Rails.application.secrets.secret_key_base
      @vc = VoteCount.find_or_create_by(video_id: params[:video_id])
      if @vc.vote(params[:username])
        render text: "@#{params[:username]} voted for #{@vc.video.title}! (Votes: #{@vc.count})"
      else
        render text: @vc.errors.messages.values[0][0], status: 200
      end
    else
      render nothing: true, status: 400
    end
  end

  def current
    #Return the current video being played
    @vp = VideoPlaying.first
    #If past beyond the time, get the next video
    # This call generates a race conditions when the video ends, something to look for in future projects
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

  def top
    #Get the current top3 most voted videos
    @vcs = VoteCount.all.order(count: :desc).limit(3)
    render text: @vcs.each_with_index.map{ |vc, i| "#{ i + 1 }. #{ vc.video.title } (#{ vc.count })"}.join(" | ")
  end

  private
  #When a new video is played reset the counter
    def resetCount
      VoteCount.all.update_all(count: 0)
      Vote.all.destroy
    end
end
