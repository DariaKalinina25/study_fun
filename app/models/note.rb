# frozen_string_literal: true

# Note model belonging to a user and a folder.
class Note < ApplicationRecord
  belongs_to :user
  belongs_to :folder

  validates :title, presence: true
end
