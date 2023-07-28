# frozen_string_literal: true

class ApplicationService
  # expects any number of kwargs and
  # a block that implements an operation on the kwargs
  def self.call(**args)
    new(**args).call
  end
end
