# frozen_string_literal: true

require 'test_helper'

class ShortUrlTest < ActiveSupport::TestCase
  test 'it has uuid after save' do
    url = ShortUrl.new(original_url: 'http://www.example.com')
    assert url.uuid.nil?

    url.save!
    assert url.uuid.present?
  end

  test 'uuid is always uniq' do
    url1 = ShortUrl.create!(original_url: 'http://www.example.com', uuid: '123456')
    url2 = ShortUrl.create!(original_url: 'http://www.example.com', uuid: '123456')

    assert url1.uuid != url2.uuid
  end

  test 'it validates original url' do
    url = ShortUrl.create(original_url: nil)
    assert_not url.valid?

    url = ShortUrl.create(original_url: 'htt://www.example.com')
    assert_not url.valid?

    url = ShortUrl.create(original_url: 'http://www.example.com')
    assert url.valid?
  end

  test 'it prevents urls changes after created' do
    url = ShortUrl.create!(original_url: 'http://www.example.com', uuid: '123456')

    url.update!(original_url: 'http://www.example.com/test')
    url.reload
    assert_equal('http://www.example.com', url.original_url)

    url.update!(uuid: 'test')
    url.reload
    assert_equal('123456', url.uuid)
  end
end
