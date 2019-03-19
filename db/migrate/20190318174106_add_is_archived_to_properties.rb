class AddIsArchivedToProperties < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :is_archived, :boolean, :default => false
  end
end
