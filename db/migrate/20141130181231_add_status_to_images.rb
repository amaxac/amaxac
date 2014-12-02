class AddStatusToImages < ActiveRecord::Migration
  def change
    add_column :images, :published, :boolean, null: false, default: false
    Image.update_all published: true
  end
end
