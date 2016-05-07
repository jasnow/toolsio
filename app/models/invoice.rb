class Invoice < ActiveRecord::Base
  validates :company, presence: true
  validates :salesperson, presence: true
  validates :tax, presence: true
  validates :date, presence: true
end
