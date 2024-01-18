# frozen_string_literal: true

require 'rails_helper'

describe 'GET root_path' do
  before do
    get root_path
  end

  it 'returns ok status' do
    expect(response).to have_http_status(:ok)
  end
end
