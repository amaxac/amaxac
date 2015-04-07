class CreateImageRatings < ActiveRecord::Migration
  def change
    create_table :image_ratings do |t|
      t.references :image
      t.inet :ip, null: false, index: true

      t.timestamps null: false
    end
  end
end
