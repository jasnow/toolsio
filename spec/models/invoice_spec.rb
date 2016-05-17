require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'validations' do
    it { should validate_presence_of :customer }
    it { should validate_presence_of :salesperson }
    it { should validate_presence_of :interest_on_arrears }
    it { should validate_presence_of :date_of_an_invoice }

    it { should validate_presence_of :refrence_nubmer }
    it { should validate_uniqueness_of :refrence_nubmer }
    it { shouol allow_value('1234').for(:refrence_nubmer) }
    it { should_not allow_value('abcd').for(:refrence_nubmer) }

    it { should validate_presence_of :choose_xor_date }
    it { should validate_presence_of :description }
  end

  describe 'associations' do
    
  end  
end
