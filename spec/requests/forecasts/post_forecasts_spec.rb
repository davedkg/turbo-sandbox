# frozen_string_literal: true

require 'rails_helper'

describe 'POST forecasts_path' do
  subject(:request) { post forecasts_path params: { forecast: forecast_params }, format: :turbo_stream }

  let(:forecast_params) { attributes_for(:forecast) }
  let(:mock_forecast_service) { MockForecastService.new }

  before do
    allow_any_instance_of(Forecast).to receive(:service).and_return(mock_forecast_service)
  end

  it 'returns ok status' do
    request
    expect(response).to have_http_status(:ok)
  end

  %i[address zip_code country].each do |attr|
    context "when #{attr} is missing" do
      before { forecast_params.delete(attr) }

      it 'returns unprocessable_entity status' do
        request
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
