# frozen_string_literal: true

module ApplicationHelper
  def render_stars(rating)
    output = ''
    if (1..5).include?(rating.to_i)
      full_stars = rating.to_i
      empty_stars = 5 - full_stars

      output += '<span class="stars">'
      full_stars.times { output += '<i class="star filled"></i>' }
      empty_stars.times { output += '<i class="star empty"></i>' }
      output += '</span>'
    end
    output.html_safe
  end
end
