require 'rails_helper'

describe 'invoices' do
  let!(:account) { create(:account_with_schema) }
  let(:user) { account.owner }

  before do
    set_subdomain(account.subdomain)
    sign_user_in(user)
  end

  it 'allows user to create invoices' do
    visit invoices_path
    click_link I18n.t('invoices.index.new_invoice_button')

    fill_in 'Company', with: 'ABB'
    fill_in 'Salesperson', with: 'Birhanu'
    fill_in 'Tax', with: '12.5'
    select_date_and_time(DateTime.now, from: 'invoice_date')

    click_button I18n.t('invoices.new.create_invoice_button')
    
    expect(page).to have_text I18n.t('invoices.create.notice_create')
    expect(page).to have_text 'ABB'
  end

  describe 'when user has invoice' do
    before do
      invoice = create(:invoice)
      visit invoices_path
    end   

    it 'allows invoice to be shown' do 
      click_link I18n.t('button.show')
      expect(page).to have_text invoice.date 
      expect(page).to have_text invoice.company
      expect(page).to have_text invoice.tax

      expect(page).to have_link edit_invoice_path(invoice)
      expect(page).to have_link invoices_path
    end

    it 'allows invoice to be edited' do
      click_link I18n.t('button.edit')
      
      fill_in 'Company', with: 'ABB'
      fill_in 'Salesperson', with: 'Birhanu'
      fill_in 'Tax', with: '12.5'
      select_date_and_time(DateTime.now, from: 'invoice_date')

    end  

    it 'allows invoice to be deleted' do
      click_link I18n.t('button.delete')
      
      #expect(page).to have_text I18n.t('invoices.index.are_you_sure')
       

    end  
  end  

  it 'displays invoice validations' do
    visit invoices_path
    click_link I18n.t('invoices.index.new_invoice_button')

    click_button I18n.t('invoices.new.create_invoice_button')
    expect(page).to have_text "can't be blank"
  end
end