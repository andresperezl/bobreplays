require 'httparty'
require 'iso8601'


class YoutubeApi
  LOLESPORTS_UPLOADS = "UUvqRdlKsE5Q8mf8YXbdIJLw"
  YOUTUBE_API_KEY = Rails.application.secrets.youtube_api_key
  BASE_URI = "https://www.googleapis.com/youtube/v3"
  VS_REGEX = /\svs\.?\s/
  NOT_REGEX = /(Teaser|Recap|Mic Check)/
  include HTTParty
  base_uri BASE_URI

  def self.get_and_update_videos
    options = {
      query: {
        part: "contentDetails,snippet",
        maxResults: 50,
        playlistId: LOLESPORTS_UPLOADS,
        key: YOUTUBE_API_KEY
      }
    }
    videos = {}
    loop do
      response = get("/playlistItems", options)
      result = response.parsed_response
      items = result["items"].select{ |item| 
        VS_REGEX.match(item["snippet"]["title"]) && 
        !NOT_REGEX.match(item["snippet"]["title"]) }
      items.each do |item|
        item_info = item["snippet"]
        title = item_info["title"]
        uploaded_on = item_info["publishedAt"]
        thumbnail = item_info["thumbnails"]["medium"]["url"]
        videoId = item_info["resourceId"]["videoId"]
        video = Video.create( title: title, videoId: videoId, thumbnail: thumbnail, uploaded_on: uploaded_on ) unless Video.find_by_videoId(videoId)
        videos[videoId] = video if video
        if videos.keys.size == 50
          get_videos_durations(videos)
          videos = {}
        end
      end
      if videos.keys.size > 0 
        get_videos_durations(videos)
      end
      options[:query][:pageToken] = result["nextPageToken"]
      break if result["nextPageToken"].nil?
    end
  end

  def self.get_videos_durations(videos)
    options = {
      query: {
        part: "contentDetails",
        id: videos.keys.join(","),
        key: YOUTUBE_API_KEY
      }
    }
    response = get("/videos", options)
    result = response.parsed_response
    items = result["items"]
    items.each do |item|
      videos[item["id"]].update(duration: ISO8601::Duration.new(item["contentDetails"]["duration"]).to_seconds)
    end
  end
end