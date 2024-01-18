# frozen_string_literal: true

require 'rails_helper'

describe Forecast do
  let(:forecast_attributes) { attributes_for(:forecast) }
  let(:mock_forecast_service) { MockForecastService.new }

  before do
    allow_any_instance_of(described_class).to receive(:service).and_return(mock_forecast_service)
  end

  describe '#valid?' do
    subject(:forecast) { described_class.new(forecast_attributes) }

    context 'when all params are present' do
      it 'returns true' do
        expect(forecast).to be_valid
      end
    end

    context 'when address is missing' do
      before { forecast_attributes.delete(:address) }

      it 'returns false' do
        expect(forecast).not_to be_valid
      end
    end

    context 'when zip_code is missing' do
      before { forecast_attributes.delete(:zip_code) }

      it 'returns false' do
        expect(forecast).not_to be_valid
      end
    end

    context 'when country is missing' do
      before { forecast_attributes.delete(:country) }

      it 'returns false' do
        expect(forecast).not_to be_valid
      end
    end
  end
end
