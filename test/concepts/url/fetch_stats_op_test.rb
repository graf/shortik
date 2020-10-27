# frozen_string_literal: true

require 'test_helper'

module Url
  class FetchStatsOpTest < ActiveSupport::TestCase
    test 'it returns url' do
      ShortUrl.create(original_url: 'http://www.test.com', uuid: 'abc')

      url = Url::FetchStatsOp.call(uuid: 'abc')

      assert url.success?
      assert url.uuid == 'abc'
    end

    test "it fails when url doesn't exist" do
      result = Url::FetchStatsOp.call(uuid: 'xxx')

      assert_not result.success?
      assert result.failure(Url::FetchStatsOp::NotFoundError)
    end
  end
end
