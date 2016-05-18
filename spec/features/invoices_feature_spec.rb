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
    click_link I18n.t('invoices.index.add_new_invoice_button')

    fill_in 'Customer', with: 'ABB'
    fill_in 'Interest on arrears', with: '12'
    fill_in 'Reference number', with: '1234'
    fill_in 'Description', with: 'Lorem lipsum'

    #select_date_and_time(DateTime.now, from: 'invoice_deadline')
    select_date(DateTime, from: 'invoice_date_of_an_invoice')
    select_date(DateTime, from: 'invoice_deadline')

    submit_form
    
    expect(page).to have_text I18n.t('invoices.create.notice_create')
    expect(page).to have_text 'ABB'
    expect(page).to have_text '12345'
  end

  it 'does not allow user to create invoices' do
    visit invoices_path
    click_link I18n.t('invoices.index.add_new_invoice_button')

    fill_in 'Customer', with: 'ABB'
    fill_in 'Interest on arrears', with: '12'
    fill_in 'Reference number', with: 'abcd'
    fill_in 'Description', with: 'Lorem lipsum'

    #select_date_and_time(DateTime.now, from: 'invoice_deadline')
    select_date(DateTime, from: 'invoice_date_of_an_invoice')
    select_date(DateTime, from: 'invoice_deadline')

    submit_form
    
    expect(page).to have_text 'is not a number'
    expect(page).to_not have_text 'ABB'
  end 
    
  describe 'when user has invoice' do
    before(:each) do
      @invoice = create(:invoice)
      visit invoices_path
    end   

    it 'allows invoice to be shown' do 
      click_link I18n.t('button.show')
      expect(page).to have_text @invoice.date 
      expect(page).to have_text @invoice.customer
      expect(page).to have_text @invoice.tax
    
      expect(page).to have_link I18n.t('button.edit')
    end

    it 'allows invoice to be edited' do
      click_link I18n.t('button.edit')
      
      fill_in 'Customer', with: 'ABB edited'
      fill_in 'Interest on arrears', with: '12'
      fill_in 'Reference number', with: '12345'
      fill_in 'Description', with: 'Lorem lipsum edited'

      select_date(DateTime, from: 'invoice_deadline')

      submit_form
      expect(page).to have_text I18n.t('invoices.update.success_update')
      expect(page).to have_text 'ABB edited'
      expect(page).to have_text 'Lorem lipsum edited'
    end  

    it 'allows invoice to be deleted' do
      within('tbody tr') do 
        click_link I18n.t('button.delete')
      end
      expect(page).to have_text I18n.t('invoices.destroy.confirmation_msg')
     
      wait_until_modal_footer do
        page.has_css?('.modal-footer')
        
        within('.modal-footer') do 
          click_link I18n.t('button.delete')
        end

        expect(page).to have_text I18n.t('invoices.destroy.success_delete')
        expect(page).to_not have_text @invoice.date
        expect(page).to_not have_text @invoice.customer
      end        
    end  
  end  

  it 'displays invoice validations' do
    visit invoices_path
    click_link I18n.t('invoices.index.add_new_invoice_button')

    click_button I18n.t('invoices.new.create_invoice_button')
    expect(page).to have_text "can't be blank"
  end
end