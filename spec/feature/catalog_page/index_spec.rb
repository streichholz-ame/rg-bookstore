describe 'Catalog Page', type: :feature do
  let!(:book) { create(:book) }

  before { visit(catalog_index_path) }

  it 'redirect to current book page' do
    find('img').hover
    find('i', class: 'fa-eye').click
    expect(page).to have_current_path(book_path(book.id))
  end

  it 'go to category' do
    find('a', class: 'filter-link', text: I18n.t('filter.show_all')).click
    find('a', text: book.category.name).click
    expect(page).to have_current_path(catalog_category_path(book.category.id))
  end
end
