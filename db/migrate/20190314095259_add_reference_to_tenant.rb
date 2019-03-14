class AddReferenceToTenant < ActiveRecord::Migration[5.2]
  def change
    add_reference :tenants, :payment_status, index: true
  end
end
