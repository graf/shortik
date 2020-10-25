# frozen_string_literal: true

module Url
  class CreateOp
    include Operation

    Error = Class.new(StandardError)

    def initialize(url:)
      @url = url
    end

    def call
      ShortUrl.create(original_url: @url)
    end
  end
end
