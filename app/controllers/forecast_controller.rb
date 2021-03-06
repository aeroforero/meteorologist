require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("forecast/coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================
    url = "https://api.darksky.net/forecast/7701ba0a638b619fcb6a11864c0dd351/" + @lat.to_s + "," + @lng.to_s
    require 'open-uri'
    raw = open(url).read
    parsed = JSON.parse(raw)

    @current_temperature = parsed["currently"]["temperature"]

    @current_summary = parsed["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed["minutely"]["summary"]

    @summary_of_next_several_hours = parsed["hourly"]["summary"]

    @summary_of_next_several_days = parsed["daily"]["summary"]

    render("forecast/coords_to_weather.html.erb")
  end
end
