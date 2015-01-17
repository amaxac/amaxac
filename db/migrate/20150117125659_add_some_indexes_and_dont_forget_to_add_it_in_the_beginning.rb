class AddSomeIndexesAndDontForgetToAddItInTheBeginning < ActiveRecord::Migration
  def change
    add_index :images, :rating
    add_index :images, :text
  end
end
