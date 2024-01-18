# frozen_string_literal: true

class ForecastsController < ApplicationController
  def index; end

  def create
    @forecast = Forecast.new(forecast_params)

    render :create_failed, status: :unprocessable_entity unless @forecast.valid?
  end

  private

  def forecast_params
    params.require(:forecast).permit(:address, :zip_code, :country)
  end
end
