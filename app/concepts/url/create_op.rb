# frozen_string_literal: true

module Url
  class CreateOp
    include Operation

    ValidationError = Class.new(Operation::Error::ValidationError)

    # @param url [String]
    def initialize(url:)
      @url = url
    end

    def call
      step :validate
      step :create_record
    end

    private

    def validate
      url = ShortUrl.new(original_url: @url)
      if !url.valid?
        fail! ValidationError, url
      else
        url
      end
    end

    def create_record
      ShortUrl.create!(original_url: @url)
    end
  end
end
