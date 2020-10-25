# frozen_string_literal: true

class UrlsController < ApplicationController
  def create
    call_operation(Url::CreateOp, url: url_param) do |url|
      if url.persisted?
        render plain: url_url(url.uuid), status: :created
      else
        render plain: url.errors.full_messages.join("\n"),
               status: :unprocessable_entity
      end
    end
  rescue Url::CreateOp::Error => e
    render plain: "Couldn't short URL. Error was: \"#{e.message}\"", status: :not_found
  end

  def show
    call_operation(Url::TouchOp, uuid: params[:uuid]) do |url|
      render plain: url.original_url, status: :ok
    end
  rescue Url::TouchOp::NotFoundError
    render plain: "URL doesn't not exist", status: :not_found
  end

  def stats
    call_operation(Url::FetchOp, uuid: params[:url_uuid]) do |url|
      render plain: url.access_count.to_s, status: :ok
    end
  rescue Url::FetchOp::Error
    render plain: 0, status: :not_found
  end

  private

  def url_param
    params[:url] || request.raw_post
  end
end
