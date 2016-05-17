class AddPaymenttermToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :payment_term, :integer
  end
end
