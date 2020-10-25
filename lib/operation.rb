# frozen_string_literal: true

module Operation
  extend ActiveSupport::Concern

  def call
    raise NotImplementedError
  end

  module ClassMethods
    def call(**args, &block)
      new(**args).call(&block)
    end
  end
end
