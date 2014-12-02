class AddShaToImage < ActiveRecord::Migration
  def change
    add_column :images, :sha, :string, null: false, default: ""
    add_index :images, :sha
  end
end
