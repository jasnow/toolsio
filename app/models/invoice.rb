class Invoice < ActiveRecord::Base
  validates :customer, presence: true
  validates :salesperson, presence: true
  validates :interest_on_arrears, presence: true
  validates :date_of_an_invoice, presence: true
  validates :deadline, presence: false, allow_nil: true
  validates :payment_term, presence: false, allow_nil: true
  validates :reference_number, presence: true, 
    uniqueness: true,
    numericality: { only_integer: true }
  validates :description, length: { maximum: 300,
    too_long: "%{count} characters is the maximum allowed" }

  validate :choose_xor_date

  private
    def choose_xor_date
      unless deadline.blank? ^ payment_term.blank?
        errors.add(:base, "Specify a deadline or a payment term, not both")
      end
    end  

end
