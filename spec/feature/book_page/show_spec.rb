describe 'Book Page', type: :feature do
  let!(:book) { create(:book, :with_author) }
  let(:count_result) { '2' }
  before { visit(book_path(book)) }

  it 'increment book count' do 
    find('i', class: 'fa-plus').click
    expect(find_field('book_count').value).to eq(count_result)
  end
  
  it 'go back to catalog page' do
    visit catalog_index_path
    visit book_path(book)
    find('a', class: 'general-back-link', text: I18n.t('book_page.back')).click
    expect(page).to have_current_path(catalog_index_path)
  end

  it 'show read more' do 
    find('a', text: I18n.t('book_page.read_more')).click
    expect(page).to have_selector('a', text: I18n.t('book_page.hide_read_more'))
  end
end