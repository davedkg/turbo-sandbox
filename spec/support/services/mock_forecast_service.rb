# frozen_string_literal: true

class MockForecastService
  def forecast_by_zipcode_and_country(_zip_code, _country)
    {
      temperature: {
        current: 68.0,
        high: 72.0,
        low: 64.0
      }
    }
  end
end
