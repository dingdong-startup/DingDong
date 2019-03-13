class CreateVisits < ActiveRecord::Migration[5.2]
  def change
    create_table :visits do |t|
      t.belongs_to :property, index: true
      t.belongs_to :tenant, index: true 
      t.belongs_to :status, index: true
      t.timestamps
    end
  end
end
