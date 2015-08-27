class AddPaymentStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :payment_status, :string, :default => 'unpaid'
  end
end
