require 'rails_helper'

describe 'Homepage', type: :feature do
  let(:all_books) { create(:category, name: 'All Books') }
  let(:design_category) { create(:category) }
  let!(:book) { create(:book, category: design_category) }

  before { visit(root_path) }

  it 'is on homepage' do
    expect(page).to have_current_path(root_path)
  end

  it 'go to all books by clicking get started btn' do
    click_link(I18n.t('homepage.get_started'))
    expect(page).to have_current_path(catalog_index_path)
  end

  it 'go to category' do
    find('a', class: 'dropdown-toggle', text: I18n.t('header.shop')).click
    find('ul', class: 'dropdown-menu').click_link(design_category.name)
    expect(page).to have_current_path(catalog_category_path(design_category.id))
  end
end
