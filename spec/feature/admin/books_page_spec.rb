require 'rails_helper'

RSpec.describe 'Admin book Page', type: feature do
  let!(:admin) { create(:admin_user) }
  let!(:category) { create(:category) }
  let!(:book) { create(:book, category: category) }
  let(:valid_attributes) { attributes_for(:book) }
  let(:blank_field_message) { "can't be blank" }

  before do
    login_as(admin, scope: :admin_user)
    visit admin_books_path
  end

  context 'New book' do
    before { click_on('New Book') }
    scenario 'with valid params' do
      fill_in 'book[name]', with: valid_attributes[:name]
      fill_in 'book[description]', with: valid_attributes[:description]
      select category.name, from: 'book_category_id'
      click_on('Create Book')
      expect(page).to have_current_path(admin_book_path(Book.last.id))
    end

    scenario 'with invalid params' do
      fill_in 'book[name]', with: ''
      fill_in 'book[description]', with: valid_attributes[:description]
      click_on('Create Book')

      expect(page).to have_content(blank_field_message)
    end

    scenario 'cancel create' do
      click_on('Cancel')
      expect(page).to have_current_path(admin_books_path)
    end
  end

  scenario 'view book' do
    click_on('View')
    expect(page).to have_content(book.name)
    expect(page).to have_content(book.description)
  end

  context 'edit book' do
    before { click_on('Edit') }
    scenario 'with valid params' do
      fill_in 'book[name]', with: valid_attributes[:name]
      click_on('Update Book')

      expect(page).to have_content(valid_attributes[:name])
    end

    scenario 'with invalid params' do
      fill_in 'book[name]', with: ''
      click_on('Update Book')
      expect(page).to have_content(blank_field_message)
    end

    scenario 'cancel Edit' do
      click_on('Cancel')
      expect(page).to have_current_path(admin_books_path)
    end
  end

  scenario 'destroy book' do
    click_on('Delete')
    text = page.driver.browser.switch_to.alert.text
    expect(text).to eq 'Are you sure you want to delete this?'
  end

  scenario 'filters' do
    fill_in 'q[name_contains]', with: book.name[0..1]
    expect(page).to have_content(book.name)
  end
end
