class RemoveSalespersonFromInvoices < ActiveRecord::Migration
  def change
    remove_column :invoices, :salesperson 
  end
end
