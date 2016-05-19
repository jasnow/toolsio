class ChangeReferencenumberDatafieldtypeToText < ActiveRecord::Migration
  def up
    change_column :invoices, :reference_number, :text
  end
  def down
    change_column :invoices, :reference_number, :string
  end
end
