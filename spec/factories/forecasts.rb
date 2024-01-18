# frozen_string_literal: true

FactoryBot.define do
  factory :forecast do
    address { '1234 5th ST, Los Theros, CA, 67891 USA' }
    zip_code { '67891' }
    country { 'US' }
  end
end
