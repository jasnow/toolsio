require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'validations' do
    it { should validate_presence_of :customer }
    it { should validate_presence_of :date_of_an_invoice }
    it { should validate_presence_of :reference_number }
    it { should validate_uniqueness_of :reference_number }

    it { should allow_value('', nil).for(:deadline) }
    it { should allow_value('', nil).for(:payment_term) }
    it { should allow_value('', nil).for(:interest_on_arrears) }
    it { should allow_value('', nil).for(:description) }
  end

  describe 'associations' do
    
  end  
end
