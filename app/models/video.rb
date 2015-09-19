require 'iso8601'
class Video < ActiveRecord::Base
  self.per_page = 36

  def formatted_duration
    value = ISO8601::Duration.new(self.duration)
    (value.to_i / 3600).to_s.rjust(2,'0') + ":" + 
      (value.to_i % 3600 / 60).to_s.rjust(2,'0') +
      ":" + (value.to_i % 3600 % 60).to_s.rjust(2,'0')
  end
end
