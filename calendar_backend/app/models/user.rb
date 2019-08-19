# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :events, through: :calendar
  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password_digest, presence: true
end
