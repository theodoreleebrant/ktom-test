class User < ApplicationRecord
  has_secure_password

  # Validation done on create and edit
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
end
