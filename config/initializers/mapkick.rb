# frozen_string_literal: true

ENV['MAPBOX_ACCESS_TOKEN'] = Rails.application.credentials[:mapkick_token]
Mapkick.options[:height] = '250px'
