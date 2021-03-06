class CreateVisits < ActiveRecord::Migration[5.2]
  def change
    create_table :visits do |t|
      t.belongs_to :property, index: true
      t.belongs_to :visit_status, index: true 
      t.belongs_to :tenant, index: true
      t.timestamps
    end
  end
end
