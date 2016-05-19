class AddDeadlineReferencenumberDescriptionToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :deadline, :date
    add_column :invoices, :reference_number, :string
    add_column :invoices, :description, :text
  end
end
