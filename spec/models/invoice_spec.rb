require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'validations' do
    it { should validate_presence_of :company }
    it { should validate_uniqueness_of :company }
    it { should validate_presence_of :salesperson }
    it { should validate_presence_of :tax }
    it { should validate_presence_of :date }

  end

  describe 'associations' do
    
  end  
end
