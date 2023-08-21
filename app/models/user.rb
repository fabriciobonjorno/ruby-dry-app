# frozen_string_literal: true

class User < ApplicationRecord
  # bcrypt config
  has_secure_password

  # validates
  validates :name, :username, :email, :password_digest, presence: true
  validates :email, :username, uniqueness: { case_sensitive: false }

  # relationships
  has_one :address, as: :addressable
  has_one :phone, as: :phoneble
end
