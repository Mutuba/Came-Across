# frozen_string_literal: true

# spec/support/matchers/upload_arguments_matcher.rb
RSpec::Matchers.define :upload_arguments do |expected_arguments|
  match do |actual_arguments|
    expect(actual_arguments.keys).to match_array(expected_arguments.keys)
    expected_arguments.all? { |key, value| expect(actual_arguments[key]).to eq(value) }
  end
end
