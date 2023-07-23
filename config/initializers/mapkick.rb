ENV['MAPBOX_ACCESS_TOKEN'] = Rails.application.credentials.dig(:mapkick_token)
Mapkick.options[:height] = "400px"
