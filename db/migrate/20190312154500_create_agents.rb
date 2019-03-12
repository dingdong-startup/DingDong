class CreateAgents < ActiveRecord::Migration[5.2]
  def change
    create_table :agents do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :cellphone
      t.belongs_to :position, index: true
      t.belongs_to :agency, index: true
      t.timestamps
    end
  end
end
