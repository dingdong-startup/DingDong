class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.boolean :is_liked
      t.belongs_to :property, index: true
      t.belongs_to :tenant, index: true
      t.timestamps
    end
  end
end
