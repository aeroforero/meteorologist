require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================
    key = "AIzaSyByJC6WbimSOroP2zI4gTEcAu91BRAzDfk"
    name = @street_address.gsub(" ","+")
    # url1 = "http://maps.googleapis.com/maps/api/geocode/json?address=" + "name" + "&sensor=false"
    url1 = "https://maps.googleapis.com/maps/api/geocode/json?address=" + name + "&key=" + key

    data = open(url1).read
    parsed_data = JSON.parse(data)


    @lat = parsed_data["results"][0]["geometry"]["location"]["lat"]

    @lng = parsed_data["results"][0]["geometry"]["location"]["lng"]

    url2 = "https://api.darksky.net/forecast/7701ba0a638b619fcb6a11864c0dd351/" + @lat.to_s + "," + @lng.to_s
    raw = open(url2).read
    parsed = JSON.parse(raw)

    @current_temperature = parsed["currently"]["temperature"]

    @current_summary = parsed["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed["minutely"]["summary"]

    @summary_of_next_several_hours = parsed["hourly"]["summary"]

    @summary_of_next_several_days = parsed["daily"]["summary"]



    render("meteorologist/street_to_weather.html.erb")
  end
end
