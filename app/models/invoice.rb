class Invoice < ActiveRecord::Base
  validates :customer, presence: true
  validates :date_of_an_invoice, presence: true
  validates :deadline, presence: true, allow_nil: true
  validates :payment_term, presence: true, allow_nil: true,
    inclusion: { in: 1..31, message: 'If you prefer to give payment term more than 31 days use the deadline dropdown bellow to select 
      dates from comming months' }
  validates :interest_on_arrears, numericality: true, allow_nil: true,
    inclusion: { in: 1..100, message: 'You cant give interest on arrears bellow 0 or more than 100%' }
  validates :reference_number, presence: true, 
    uniqueness: true,
    numericality: { only_integer: true }
  validates :description, length: { maximum: 300,
    too_long: "%{count} characters is the maximum allowed" }

  validate :choose_xor_date

  private
  def choose_xor_date
    unless deadline.blank? ^ payment_term.blank?
      errors.add(:base, 'specify a deadline or a payment term. Not both empty, nor both filled')        
    end
  end  

end
