# frozen_string_literal: true

# Folder model with hierarchical structure using Ancestry.
class Folder < ApplicationRecord
  belongs_to :user
  has_many :notes, dependent: :destroy

  has_ancestry

  validates :name, presence: true

  validate :limit_nesting_depth

  private

  def limit_nesting_depth
    return unless depth >= 2

    errors.add(:ancestry, I18n.t('folder.errors.depth_limit'))
  end
end
