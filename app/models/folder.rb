class Folder < ApplicationRecord
  belongs_to :user
  has_many :notes, dependent: :destroy

  has_ancestry

  validates :title, presence: true

  validate :limit_nesting_depth

  private

  def limit_nesting_depth
    if depth >= 2
      errors.add(:ancestry, I18n.t('folder.errors.depth_limit'))
    end
  end
end
