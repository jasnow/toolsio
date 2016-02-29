require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'validations' do
    it { should validate_presence_of :company }
    it { should validate_presence_of :salesperson }
    it { should validate_presence_of :tax }
    it { should validate_presence_of :date }

    it { should allow_value('company').for(:company) }
    it { should allow_value('salesperson').for(:salesperson) }
    it { should allow_value('23.7').for(:tax) }
    it { should allow_value(new Date).for(:date) }

    it { should_not_allow_value('seven').for(:tax) }
    it { should_not_allow_value('today').for(:date) }
  end

  describe 'associations' do
    it 'Should have owner'
  end  
end
