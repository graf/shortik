# frozen_string_literal: true

module Operation
  module Error
    class ValidationError
      attr_reader :model

      delegate :errors, to: :model

      def initialize(model)
        @model = model
      end
    end
  end
end
