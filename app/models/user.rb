# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_parties, dependent: nil
  has_many :parties, through: :user_parties

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :name, presence: true
  validates :password_digest, presence: true

  has_secure_password
end
