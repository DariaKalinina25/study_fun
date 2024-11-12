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
