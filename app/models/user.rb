class User < ApplicationRecord
  has_secure_password

  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  has_many :teams, dependent: :nullify

  has_many :seasons, through: :teams

  validates :email_address,
    presence: true,
    length: { maximum: 255 },
    uniqueness: { case_sensitive: false },
    format: { allow_blank: true, with: URI::MailTo::EMAIL_REGEXP }
end
