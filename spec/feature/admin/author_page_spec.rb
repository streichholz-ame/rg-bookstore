require 'rails_helper'

RSpec.describe 'Admin Author Page', type: feature do
  let!(:admin) { create(:admin_user) }
  let!(:author) { create(:author) }
  let(:valid_attributes) { attributes_for(:author) }
  let(:blank_field_message) { "can't be blank" }

  before do
    login_as(admin, :scope => :admin_user)
    visit admin_authors_path
  end

  context 'create Author' do
    before { click_on('New Author') }
    scenario 'with valid params' do
      fill_in 'author[first_name]', with: valid_attributes[:first_name]
      fill_in 'author[last_name]', with: valid_attributes[:last_name]
      fill_in 'author[description]', with: valid_attributes[:description]
      click_on('Create Author')
      expect(page).to have_current_path(admin_author_path(Author.last.id))
    end

    scenario 'with invalid params' do
      fill_in 'author[first_name]', with: ''
      fill_in 'author[last_name]', with: valid_attributes[:last_name]
      fill_in 'author[description]', with: valid_attributes[:description]
      click_on('Create Author')

      expect(page).to have_content(blank_field_message)
    end

    scenario 'cancel create' do
      click_on('Cancel')
      expect(page).to have_current_path(admin_authors_path)
    end
  end

  scenario 'view Author' do
    click_on('View')
    expect(page).to have_content(author.first_name)
    expect(page).to have_content(author.last_name)
    expect(page).to have_content(author.description)
  end

  context 'edit Author' do
    before { click_on('Edit') }
    scenario 'with valid params' do
      fill_in 'author[first_name]', with: valid_attributes[:first_name]
      fill_in 'author[last_name]', with: valid_attributes[:last_name]
      click_on('Update Author')

      expect(page).to have_content(valid_attributes[:first_name])
      expect(page).to have_content(valid_attributes[:last_name])
      expect(page).to have_content(author.description)
    end

    scenario 'with invalid params' do
      fill_in 'author[first_name]', with: ''
      click_on('Update Author')
      expect(page).to have_content(blank_field_message)
    end

    scenario 'cancel Edit' do
      click_on('Cancel')
      expect(page).to have_current_path(admin_authors_path)
    end
  end

  scenario 'destroy Author' do
    click_on('Delete')
    text = page.driver.browser.switch_to.alert.text
    expect(text).to eq 'Are you sure you want to delete this?'
  end

  scenario 'filters' do
    fill_in 'q[first_name_contains]', with: author.first_name[0..1]
    expect(page).to have_content(author.first_name)
  end
end