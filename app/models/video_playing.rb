class VideoPlaying < ActiveRecord::Base
  belongs_to :video

  default_scope{ order(start_time: :desc) }

end
