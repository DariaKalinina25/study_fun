# frozen_string_literal: true

# User model with Devise authentication modules.
class User < ApplicationRecord
  has_many :folders, dependent: :destroy
  has_many :notes, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
