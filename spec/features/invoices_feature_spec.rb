require 'rails_helper'

describe 'invoices' do
  it 'allows user to create invoices'
    visit invoices_path

    click_link 'Invoices'
  end
end