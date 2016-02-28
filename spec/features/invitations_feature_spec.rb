require 'rails_helper'

describe 'invitations' do
  let!(:account) { create(:account_with_schema) }
  let(:user) { account.owner }

  before do
  	set_subdomain(account.subdomain)
  	sign_user_in(user)
  	visit users_path
  end

  it 'validates email' do
    fill_in 'Email', with: 'wrong'
    click_button 'Invite User'
    expect(page).to have_content 'Send Invitation'
    expect(page).to have_content 'invalid'
  end

  it 'shows the owner in the authorized users list' do
   	expect(page).to have_content user.first_name
    expect(page).to have_content user.second_name
  	expect(page).to have_content user.email
  	expect(page).to have_css '.glyphicon-ok'
  end

  describe 'when user is invited' do
    before do
      fill_in 'Email', with: 'birhanuh@bizdesk.com'
      click_button 'Invite User'
    end

    it 'shows invitation when user is invited' do
    	expect(page).to have_content 'invitation email has been sent'
    	expect(page).to have_content 'birhanuh@bizdesk.com'
    	expect(page).to have_content 'Invitation Pending'
    end

    context 'user accepts invitation' do
      before do
        click_link 'Sign out'

        open_email 'birhanuh@bizdesk.com'
        visit_in_email 'Accept invitation'

        fill_in 'First name', with: 'birhanuh'
        fill_in 'Second name', with: 'Hailemariam'
        fill_in 'Password confirmation', with: 'pw'
        click_button 'Create Account'
      end

      it 'confirms account creation' do
        expect(page).to have_content 'Your account was created successfuly'
      end

      it 'shows a check mark on the user page' do
        visit users_path
        within('tr', text: 'Birhanu') do
          expect(page).to have_content '.glyphicon-ok'
        end
      end
    end
  end
end