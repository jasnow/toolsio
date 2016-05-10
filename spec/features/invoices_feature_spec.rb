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
    before(:each) do
      @invoice = create(:invoice)
      visit invoices_path
    end   

    it 'allows invoice to be shown' do 
      click_link I18n.t('button.show')
      expect(page).to have_text @invoice.date 
      expect(page).to have_text @invoice.company
      expect(page).to have_text @invoice.tax
    
      expect(page).to have_link I18n.t('button.edit')
    end

    it 'allows invoice to be edited' do
      click_link I18n.t('button.edit')
      
      fill_in 'Company', with: 'ABB'
      fill_in 'Salesperson', with: 'Birhanu'
      fill_in 'Tax', with: '12.5'
      select_date_and_time(DateTime.now, from: 'invoice_date')

      submit_form
      expect(page).to have_text I18n.t('invoices.update.success_update')
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
        expect(page).to_not have_text @invoice.company
      end        
    end  
  end  

  it 'displays invoice validations' do
    visit invoices_path
    click_link I18n.t('invoices.index.new_invoice_button')

    click_button I18n.t('invoices.new.create_invoice_button')
    expect(page).to have_text "can't be blank"
  end
end