# frozen_string_literal: true

class Forecast
  include ActiveModel::Model

  attr_accessor :address, :zip_code, :country # input attributes
  attr_reader :temperature_current, :temperature_max, :temperature_min # output attributes

  validates :address, presence: true
  # if address isn't present, we will assume so is the zip_code and country
  validates :zip_code, :country, presence: true, if: -> { errors.empty? }
  validate :populate_current_forecast, if: -> { errors.empty? }

  def populate_current_forecast
    current_forecast = service.forecast_by_zipcode_and_country(zip_code, country)

    errors.add(:address, 'has no forecast') unless current_forecast

    forecast_temperature = current_forecast[:temperature]

    @temperature_current = forecast_temperature[:current]
    @temperature_max = forecast_temperature[:high]
    @temperature_min = forecast_temperature[:low]
  end

  private

  def service
    @service ||= ForecastService.new
  end
end
