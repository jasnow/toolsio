class ChangeDatetimeDatafieldtypeToDate < ActiveRecord::Migration
  def up
    change_column :invoices, :date, :date
  end
  def down
    change_column :invoices, :date, :datetime
  end
end
