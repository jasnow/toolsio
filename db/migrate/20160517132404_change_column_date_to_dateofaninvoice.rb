class ChangeColumnDateToDateofaninvoice < ActiveRecord::Migration
  def change
    rename_column :invoices, :date, :date_of_an_invoice
  end
end
