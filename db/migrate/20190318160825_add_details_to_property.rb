class AddDetailsToProperty < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :charges, :integer
    add_column :properties, :agency_fees, :integer
    add_column :properties, :deposit, :integer
    add_column :properties, :furnished, :boolean
  end
end
