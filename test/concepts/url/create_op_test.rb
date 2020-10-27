# frozen_string_literal: true

require 'test_helper'

module Url
  class CreateOpTest < ActiveSupport::TestCase
    test 'it creates record' do
      url = Url::CreateOp.call(url: 'http://www.example.com')

      assert url.success?
      assert url.persisted?
    end

    test 'ii fails on invalid url' do
      result = Url::CreateOp.call(url: 'invalid')

      assert_not result.success?

      error = result.failure(Url::CreateOp::ValidationError)
      assert error.model.errors.any?
    end
  end
end
