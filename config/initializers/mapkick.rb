# frozen_string_literal: true

ENV['MAPBOX_ACCESS_TOKEN'] = Rails.application.credentials.dig(:mapkick_token)
Mapkick.options[:height] = '250px'
Mapkick.options[:width] = '50vw'