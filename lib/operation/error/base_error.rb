# frozen_string_literal: true

module Operation
  module Error
    class BaseError
      attr_reader :message

      def initialize(message)
        @message = message
      end
    end
  end
end
