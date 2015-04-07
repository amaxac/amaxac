class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :link, null: false
      t.string :text, null: false
      t.integer :rating, null: false, default: 0
      t.inet :added_by, null: false

      t.timestamps null: false
    end
  end
end
