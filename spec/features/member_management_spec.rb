require 'rails_helper'
feature 'MemberManagement' do

  scenario 'Adding a new member' do
    visit '/members/new'
    fill_in 'name', with: "Test Name"
    fill_in 'email', with: "test@gmail.com"
    click_button 'Create'
    expect(page).to have_content 'Test Name'
  end
end
