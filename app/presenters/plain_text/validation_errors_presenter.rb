# frozen_string_literal: true

module PlainText
  class ValidationErrorsPresenter
    # @param errors [ActiveModel::Errors]
    def initialize(errors)
      @errors = errors
    end

    # @return [String]
    def as_plain_text(_options = nil)
      @errors.full_messages.join("\n")
    end
  end
end
