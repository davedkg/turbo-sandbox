# frozen_string_literal: true

class ForecastService
  # fetches forecast from 3rd party API
  # returns: { temperature: { current:, high:, low: } }
  def forecast_by_zipcode_and_country(zip_code, country)
    data = client.current_zip(zip_code, country)
    main = data.main

    {
      temperature: {
        current: main.temp_f,
        high: main.temp_max_f,
        low: main.temp_min_f
      }
    }
  end

  private

  def client
    @client ||= OpenWeather::Client.new(
      api_key: Rails.application.credentials.open_weather_api_key
    )
  end
end
