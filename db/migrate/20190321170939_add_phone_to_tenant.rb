class AddPhoneToTenant < ActiveRecord::Migration[5.2]
  def change
    add_column :tenants, :phone_number, :string
  end
end
