require "sinatra"
require "sinatra/reloader"
require "httparty"

def view(template); erb template.to_sym; end

get "/" do
  ### Get the weather
  lat = 42.0574063
  long = -87.6722787

  units = "imperial" # or metric
  weather_key = "e382174450741203b5f19184518326e5" 

  url = "https://api.openweathermap.org/data/2.5/onecall?lat=#{lat}&lon=#{long}&units=#{units}&appid=#{weather_key}"
  @forecast = HTTParty.get(url).parsed_response.to_hash
  @day_number=1
  ### Get the news
  news_key = "506191c9c05f4e31baf54ff587752cee"
  url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=#{news_key}"
  @news = HTTParty.get(url).parsed_response.to_hash
  @news_to_disp= @news["articles"][0,5]  
view 'news'
end
