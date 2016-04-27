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

  it 'displays invoice validations' do
    visit invoices_path
    click_link I18n.t('invoices.index.new_invoice_button')

    click_button I18n.t('invoices.new.create_invoice_button')
    expect(page).to have_text "can't be blank"
  end
end