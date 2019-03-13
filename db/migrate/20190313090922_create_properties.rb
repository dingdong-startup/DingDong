class CreateProperties < ActiveRecord::Migration[5.2]
  def change
    create_table :properties do |t|

    t.string :title
    t.integer :price
    t.integer :surface
    t.text :description
    t.integer :floor
    t.integer :room
    t.datetime :available_date
    t.text :address
    t.belongs_to :agency, index: true
    t.belongs_to :agent, index: true
    t.belongs_to :area, index: true
      t.timestamps
    end
  end
end
