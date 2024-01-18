# frozen_string_literal: true

class Forecast
  include ActiveModel::Model

  CACHE_EXPIRES_IN = 30.minutes

  attr_accessor :address, :zip_code, :country # input attributes
  attr_reader :temperature_current, :temperature_max, :temperature_min # output attributes

  validates :address, presence: true
  # if address isn't present, we will assume so is the zip_code and country
  validates :zip_code, :country, presence: true, if: -> { errors.empty? }
  validate :populate_current_forecast, if: -> { errors.empty? }

  def cached?
    @cached
  end

  def populate_current_forecast
    current_forecast = fetch_cached_forecast

    @cached = !current_forecast.nil? # see cached?

    current_forecast ||= fetch_new_forecast

    errors.add(:address, 'has no forecast') unless current_forecast

    forecast_temperature = current_forecast[:temperature]

    @temperature_current = forecast_temperature[:current]
    @temperature_max = forecast_temperature[:high]
    @temperature_min = forecast_temperature[:low]
  end

  private

  def fetch_cached_forecast
    response = Rails.cache.read(cache_key)

    response&.symbolize_keys
  end

  def fetch_new_forecast
    response = service.forecast_by_zipcode_and_country(zip_code, country)

    Rails.cache.write(cache_key, response, expires_in: CACHE_EXPIRES_IN)

    response
  end

  def cache_key
    @cache_key ||= "forecasts-#{country.downcase}-#{zip_code}"
  end

  def service
    @service ||= ForecastService.new
  end
end
