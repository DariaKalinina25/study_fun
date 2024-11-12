# frozen_string_literal: true

# This migration creates the folders table with necessary columns,
# including name, ancestry for hierarchical relationships,
# and a reference to the user.
class CreateFolders < ActiveRecord::Migration[7.1]
  def change
    create_table :folders do |t|
      t.string :name, null: false
      t.string :ancestry, collation: 'C', null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :folders, :ancestry
  end
end
