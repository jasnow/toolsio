class ChangeColumnTaxToInterestonarrears < ActiveRecord::Migration
  def change
    rename_column :invoices, :tax, :interest_on_arrears
  end
end
