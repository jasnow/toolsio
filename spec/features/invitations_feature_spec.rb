require 'rails_helper'

describe 'invitations' do
  let!(:account) { create(:account_with_schema) }
  let(:user) { account.user }

  before do 
  	set_subdomain(account.subdomain) 
  	sign_user_in(user)
  	visit users_path
  end

  it 'shows the owner in the authorized users list' do
   	expect(page).to have_content user.name
  	expect(page).to have_content user.email
  	expect(page).to have_content '.glyphicon-ok'
  end	

  it 'shows invitation when user is invited' do 
  	fill_in 'Email', with: 'birhanuh@bizdesk.com'
  	click_button 'Invite User'
  	expect(page).to have_content 'invitation email has been sent'
  	expect(page).to have_content 'birhanuh@bizdesk.com'
  	expect(page).to have_content 'Invitation Pending'
  end
  	
end