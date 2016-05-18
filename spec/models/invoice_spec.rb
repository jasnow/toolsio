require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'validations' do
    it { should validate_presence_of :customer }
    it { should validate_presence_of :date_of_an_invoice }
    it { should validate_presence_of :reference_number }
    it { should validate_uniqueness_of :reference_number }

    it { should validate_presence_of :choose_xor_date }
    
    it { should allow_value('', nil).for(:interest_on_arrears) }
    it { should allow_value('', nil).for(:description) }
    it { should allow_value('1').for(:interest_on_arrears) }
    it { should allow_value('lorem').for(:description) }
  end

  describe 'associations' do
    
  end  
end
