# frozen_string_literal: true

class UrlsController < ApplicationController
  def create
    call_operation(Url::CreateOp, url: url_param) do |result|
      result.success { render plain: url_url(result.uuid), status: :created }
      result.failure(Url::CreateOp::ValidationError) do |e|
        render plain: e.model.errors.full_messages.join("\n"),
               status: :unprocessable_entity
      end
    end
  end

  def show
    call_operation(Url::TouchOp, uuid: params[:uuid]) do |result|
      result.success { render plain: result.original_url, status: :ok }
      result.failure(Url::TouchOp::NotFoundError) do
        render plain: I18n.t('controllers.urls.show.not_found_error'), status: :not_found
      end
    end
  end

  def stats
    call_operation(Url::FetchStatsOp, uuid: params[:url_uuid]) do |result|
      result.success { render plain: result.access_count.to_s, status: :ok }
      result.failure(Url::FetchStatsOp::NotFoundError) do
        render plain: I18n.t('controllers.urls.stats.not_found_error'), status: :not_found
      end
    end
  end

  private

  def url_param
    params[:url] || request.raw_post
  end
end
