# frozen_string_literal: true

module Url
  class TouchOp
    include Operation

    Error = Class.new(StandardError)
    NotFoundError = Class.new(Error)

    def initialize(uuid:)
      @uuid = uuid
    end

    def call
      url = fetch_url(@uuid)
      increment_access_count(url)
      url
    end

    private

    def increment_access_count(url)
      url.increment!(:access_count)
    end

    def fetch_url(uuid)
      Url::FetchOp.call(uuid: uuid)
    rescue Url::FetchOp::Error => e
      raise NotFoundError, e
    end
  end
end
