# frozen_string_literal: true

require 'test_helper'

class UrlsControllerTest < ActionDispatch::IntegrationTest
  test 'POST /urls creates and short url' do
    post '/urls', params: {
      url: 'http://www.test.com'
    }

    assert_response :success
    assert_match(%r{http://www\.example\.com/urls/[a-hjkmnp-z2-9]{5}$}, @response.body)
  end

  test 'GET /urls/abc returns original urls' do
    ShortUrl.create(original_url: 'http://www.test.com', uuid: 'abc')

    get '/urls/abc'

    assert_response :success
    assert_equal 'http://www.test.com', @response.body
  end

  test "GET /urls/abc increase url's access counter" do
    url = ShortUrl.create(original_url: 'http://www.test.com', uuid: 'abc')

    get '/urls/abc'

    url.reload
    assert_equal 1, url.access_count
  end

  test 'GET /urls/xxx returns 404' do
    get '/urls/xxx'

    assert_response :not_found
    assert_equal "URL doesn't not exist", @response.body
  end

  test "GET /urls/abc/stats returns url's access counter" do
    ShortUrl.create(original_url: 'http://www.test.com', uuid: 'abc', access_count: 666)

    get '/urls/abc/stats'

    assert_equal '666', @response.body
  end

  test 'GET /urls/xxx/stats returns 404' do
    get '/urls/xxx/stats'

    assert_response :not_found
    assert_equal "URL doesn't not exist", @response.body
  end

  test 'POST /urls returns errors on incorrect input URL' do
    post '/urls', params: {
      url: 'invalid'
    }

    assert_response :unprocessable_entity
    assert_equal 'Original url is not a valid URL', @response.body
  end
end
