class AddDocumentsToTenants < ActiveRecord::Migration[5.2]
  def change
    add_column :tenants, :documents, :text
  end
end
