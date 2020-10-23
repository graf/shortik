# frozen_string_literal: true

class ShortUrl < ApplicationRecord
  ALLOWED_CHARS = (('a'..'z').to_a + ('0'..'9').to_a - %w[i o l 1 0]).freeze
  UUID_LENGTH = 5

  attr_readonly :uuid,
                :original_url

  validates :original_url,
            presence: true,
            url: true

  before_create :generate_unique_url_id

  private

  def generate_unique_url_id
    loop do
      break if uuid.present? && !ShortUrl.exists?(uuid: uuid)

      self.uuid = ALLOWED_CHARS.sample(UUID_LENGTH).join('')
    end
  end
end
