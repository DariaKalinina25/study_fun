# frozen_string_literal: true

class Note < ApplicationRecord
  belongs_to :user
  belongs_to :folder

  validates :title, presence: true
end
