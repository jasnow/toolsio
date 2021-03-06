require 'rails_helper'

describe 'invitations' do
  let!(:account) { create(:account_with_schema) }
  let(:user) { account.owner }

  before do
  	set_subdomain(account.subdomain)
  	sign_user_in(user)
  end

  it "allows projects to be created" do
  	visit projects_path
  	click_link I18n.t('projects.index.create_new_project_button')

  	fill_in "Name", with: "A great project"
  	fill_in "Client", with: "NASA"
  	expect(page).to_not have_text "Archived"
  	submit_form

  	expect(page).to have_text I18n.t('projects.new.notice_create')
  	expect(page).to have_text "A great project"
  end

  it "displays project validations" do
  	visit projects_path
    click_link I18n.t('projects.index.create_new_project_button')
    
  	submit_form
  	expect(page).to have_text "can't be blank"
  end

  it "allows projects to be edited" do
  	project = create(:project)

  	visit projects_path
  	click_edit_project_button project.name

  	fill_in "Name", with: "A new name"
  	check "Archived"
  	submit_form

  	expect(page).to have_text I18n.t('projects.update.notice_update')
  	expect(page).to have_text "A new name"
  end

  def click_edit_project_button(project_name)
  	within find("h3", text: project_name) do
  		page.first("a").click
  	end
  end
end