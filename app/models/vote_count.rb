class VoteCount < ActiveRecord::Base
  belongs_to :video
  before_create :set_last_win_at

  def vote(username)
    if last_win_at < 6.hours.ago
      if Vote.where(video_id: self.video_id).find_by_username(username).nil?
        Vote.create(username: username, video_id: self.video_id)
        increment!(:count)
      else
        self.errors.add(:video_id, "You (#{username}) already voted for this video in this round.")
        false
      end
    else
     self.errors.add(:last_win_at, "This video was played less than 6 hours ago.")
      false
    end
  end

  def set_last_win_at
    self.last_win_at = 6.hours.ago
  end
end
