# frozen_string_literal: true

# spec/support/geocoder_stubs.rb
module GeocoderStubs
  extend ActiveSupport::Concern

  included do
    before do
      Geocoder::Lookup::Test.set_default_stub(
        [
          {
            'latitude' => 37.774929,
            'longitude' => -122.419418,
            'address' => 'San Francisco, CA, USA',
            'state' => 'California',
            'state_code' => 'CA',
            'country' => 'United States',
            'country_code' => 'US'
          }
        ]
      )
    end
  end
end
