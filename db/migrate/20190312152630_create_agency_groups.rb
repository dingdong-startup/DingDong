class CreateAgencyGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :agency_groups do |t|
      t.belongs_to :agency, index: true
      t.belongs_to :group, index: true
      t.timestamps
    end
  end
end
