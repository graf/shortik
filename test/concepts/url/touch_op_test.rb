# frozen_string_literal: true

require 'test_helper'

module Url
  class TouchOpTest < ActiveSupport::TestCase
    test 'it returns url' do
      ShortUrl.create(original_url: 'http://www.test.com', uuid: 'abc')

      url = Url::TouchOp.call(uuid: 'abc')

      assert url.success?
      assert url.uuid == 'abc'
    end

    test 'it increment access counter' do
      ShortUrl.create(original_url: 'http://www.test.com', uuid: 'abc')

      url = Url::TouchOp.call(uuid: 'abc')

      assert url.success?
      assert url.access_count == 1
    end

    test "it fails when url doesn't exist" do
      result = Url::TouchOp.call(uuid: 'xxx')

      assert_not result.success?
      assert result.failure(Url::TouchOp::NotFoundError)
    end
  end
end
