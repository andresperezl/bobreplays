require 'iso8601'
class Video < ActiveRecord::Base
  has_one :vote_count
  has_many :votes
  default_scope{ order(uploaded_on: :desc) }
  self.per_page = 36

  def formatted_duration
    value = ISO8601::Duration.new(self.duration)
    (value.to_i / 3600).to_s.rjust(2,'0') + ":" + 
      (value.to_i % 3600 / 60).to_s.rjust(2,'0') +
      ":" + (value.to_i % 3600 % 60).to_s.rjust(2,'0')
  end
end
