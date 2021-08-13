require 'rails_helper'

RSpec.describe 'Admin category Page', type: feature do
  let!(:admin) { create(:admin_user) }
  let!(:category) { create(:category) }
  let(:valid_attributes) { attributes_for(:category) }
  let(:blank_field_message) { "can't be blank" }

  before do
    login_as(admin, scope: :admin_user)
    visit admin_categories_path
  end

  context 'New category' do
    before { click_on('New Category') }
    scenario 'with valid params' do
      fill_in 'category[name]', with: valid_attributes[:name]
      click_on('Create Category')
      expect(page).to have_current_path(admin_category_path(Category.last.id))
    end

    scenario 'with invalid params' do
      fill_in 'category[name]', with: ''
      click_on('Create Category')

      expect(page).to have_content(blank_field_message)
    end

    scenario 'cancel create' do
      click_on('Cancel')
      expect(page).to have_current_path(admin_categories_path)
    end
  end

  scenario 'view category' do
    click_on('View')
    expect(page).to have_content(category.name)
  end

  context 'edit category' do
    before { click_on('Edit') }
    scenario 'with valid params' do
      fill_in 'category[name]', with: valid_attributes[:name]
      click_on('Update Category')

      expect(page).to have_content(valid_attributes[:name])
    end

    scenario 'with invalid params' do
      fill_in 'category[name]', with: ''
      click_on('Update Category')
      expect(page).to have_content(blank_field_message)
    end

    scenario 'cancel Edit' do
      click_on('Cancel')
      expect(page).to have_current_path(admin_categories_path)
    end
  end

  scenario 'destroy category' do
    click_on('Delete')
    text = page.driver.browser.switch_to.alert.text
    expect(text).to eq 'Are you sure you want to delete this?'
  end

  scenario 'filters' do
    fill_in 'q[name_contains]', with: category.name[0..1]
    expect(page).to have_content(category.name)
  end
end
