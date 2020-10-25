# frozen_string_literal: true

module Url
  class FetchOp
    include Operation

    Error = Class.new(StandardError)

    def initialize(uuid:)
      @uuid = uuid
    end

    def call
      ShortUrl.find_by!(uuid: @uuid)
    rescue ActiveRecord::RecordNotFound => e
      raise Error, e
    end
  end
end
