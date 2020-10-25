# frozen_string_literal: true

module Url
  class FetchStatsOp
    include Operation

    NotFoundError = Class.new(Operation::Error::BaseError)

    # @param uuid [String]
    def initialize(uuid:)
      @uuid = uuid
    end

    def call
      step :find_url_by_uuid
    rescue ActiveRecord::RecordNotFound
      fail! NotFoundError, "Can't find URL with uuid = #{@uuid}"
    end

    private

    def find_url_by_uuid
      ShortUrl.find_by!(uuid: @uuid)
    end
  end
end
