require 'iso8601'
class Video < ActiveRecord::Base
  has_one :vote_count, dependent: :destroy
  has_many :votes, dependent: :destroy
  default_scope{ order(uploaded_on: :desc) }
  self.per_page = 36

  def formatted_duration
    value = ISO8601::Duration.new(self.duration)
    (value.to_i / 3600).to_s.rjust(2,'0') + ":" + 
      (value.to_i % 3600 / 60).to_s.rjust(2,'0') +
      ":" + (value.to_i % 3600 % 60).to_s.rjust(2,'0')
  end
end
