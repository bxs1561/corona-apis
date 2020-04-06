require 'httparty'
class ApisController < ApplicationController

  # other api summary with global and countries, this api is not accurate, does not update frequently
  def corona_api
    endpoint = 'https://api.covid19api.com/summary'
    response = HTTParty.get(endpoint)
    data = JSON.parse response.body
    res = data["Countries"]
    globe = data["Global"]
    result =[]
    # glob.each do |total|
      result <<{
          country: "World",
          NewConfirmed: globe["NewConfirmed"],
          TotalConfirmed: globe["TotalConfirmed"],
          NewDeaths: globe["NewDeaths"],
          TotalDeaths: globe["TotalDeaths"],
          NewRecovered: globe["NewRecovered"],
          TotalRecovered: globe["TotalRecovered"]
      }
    res.each do |place|
      result <<{

          # Global: place
          Country: place["Country"],
          CountryCode: place["CountryCode"],
          Slug: place["Slug"],
          NewConfirmed: place["NewConfirmed"],
          TotalConfirmed: place["TotalConfirmed"],
          NewDeaths: place["NewDeaths"],
          TotalDeaths: place["TotalDeaths"],
          NewRecovered: place["NewRecovered"],
          TotalRecovered: place["TotalRecovered"],
      Date: DateTime.parse(place["Date"]).strftime('%b %d, %Y, %A | %I:%M:%S %p')
      }
    end

    render json: result

  end

  # Api only for world total
  def corona_virus
    endpoint = "https://corona.lmao.ninja/all"
    response = HTTParty.get(endpoint)
    data = JSON.parse response.body
    res = data
    result = []
    result<<{
        country: "world",
        cases: res["cases"],
        todayCases: res["todayCases"],
        deaths: res["deaths"],
        todayDeaths: res["todayDeaths"],
        recovered: res["recovered"],
        active: res["active"],
        critical: res["critical"],
        casesPerOneMillion: res["casesPerOneMillion"],
        deathsPerOneMillion: res["deathsPerOneMillion"],
        tests: res["tests"],
        testsPerOneMillion: res["testsPerOneMillion"],
        affectedCountries: res["affectedCountries"]
    }
    render json: result
  end

  # Api for world'total and each countries with lat, longitude and flag
  def country_api
    endpoint = "https://corona.lmao.ninja/countries"
    response = HTTParty.get(endpoint)
    data = JSON.parse response.body
    res = data
    result =[]
    endpoint_all = "https://corona.lmao.ninja/all"
    response1 = HTTParty.get(endpoint_all)
    data1 = JSON.parse response1.body
    res1 = data1
    result<<{
        country: "world",
        cases: res1["cases"],
        todayCases: res1["todayCases"],
        deaths: res1["deaths"],
        todayDeaths: res1["todayDeaths"],
        recovered: res1["recovered"],
        active: res1["active"],
        critical: res1["critical"],
        casesPerOneMillion: res1["casesPerOneMillion"],
        deathsPerOneMillion: res1["deathsPerOneMillion"],
        tests: res1["tests"],
        testsPerOneMillion: res1["testsPerOneMillion"],
        affectedCountries: res1["affectedCountries"]
    }

    res.each do |country|
      result<<{
          country: country["country"],
          lat: country["countryInfo"]["lat"],
          long: country["countryInfo"]["long"],
          flag: country["countryInfo"]["flag"],
          cases: country["cases"],
          todayCases: country["todayCases"],
          deaths: country["deaths"],
          todayDeaths: country["todayDeaths"],
          recovered: country["recovered"],
          active: country["active"],
          critical: country["critical"],
          casesPerOneMillion: country["casesPerOneMillion"],
          deathsPerOneMillion: country["deathsPerOneMillion"],
          tests: country["tests"],
          testsPerOneMillion: country["testsPerOneMillion"]
      }
    end
    render json: result
  end

  def index
    @api = "types countries or all to see data"
  end
end
