# frozen_string_literal: true

class UrlsController < ApplicationController
  def create
    @url = ShortUrl.new(original_url: url_param)
    if @url.valid?
      @url.save!
      render plain: url_url(@url.uuid), status: :ok
    else
      render plain: PlainText::ValidationErrorsPresenter.new(@url.errors).as_plain_text,
             status: :unprocessable_entity
    end
  end

  def show
    @url = ShortUrl.find_by!(uuid: params[:uuid])
    @url.increment!(:access_count)
    render plain: @url.original_url, status: :ok
  end

  def stats
    @url = ShortUrl.find_by!(uuid: params[:url_uuid])
    render plain: @url.access_count.to_s, status: :ok
  end

  private

  def url_param
    params[:url] || request.raw_post
  end
end
