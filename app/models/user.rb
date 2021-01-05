# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :submissions

  ROLES = { 0 => :guest, 1 => :user, 2 => :marker, 3 => :admin }.freeze

  # Validation done on create and edit
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true

  def role?(role_name)
    ROLES[role.to_i] == role_name
  end
end
