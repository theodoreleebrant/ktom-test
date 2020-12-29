# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :submissions

  ROLES = { 0 => :guest, 1 => :user, 2 => :marker, 3 => :admin }.freeze

  # Validation done on create and edit
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }

  # initialization of role
  # def initialize(role_id = 1)
  #   role = ROLES.has_key?(role_id.to_i) ? ROLES[role_id.to_i] : ROLES[0]
  # end

  def role?(role_name)
    ROLES[role.to_i] == role_name
  end
end
