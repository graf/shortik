# frozen_string_literal: true

module Operation
  module Error
    class ValidationError < BaseError
      attr_reader :model

      delegate :errors, to: :model

      def initialize(model)
        super('Validation failed')
        @model = model
      end
    end
  end
end
