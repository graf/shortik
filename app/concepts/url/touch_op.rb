# frozen_string_literal: true

module Url
  class TouchOp
    include Operation

    NotFoundError = Class.new(Operation::Error::BaseError)

    # @param uuid [String]
    def initialize(uuid:)
      @uuid = uuid
    end

    def call
      step :find_url
      step :increment_access_count
    end

    private

    def increment_access_count
      @url.increment!(:access_count)
    end

    def find_url
      @url ||= ShortUrl.find_by!(uuid: @uuid)
    rescue ActiveRecord::RecordNotFound
      fail! NotFoundError, "Can't find URL with uuid = #{@uuid}"
    end
  end
end
