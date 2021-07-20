require 'rails_helper'

RSpec.describe CatalogPresenter do
  let(:catalog) { described_class.new(sort: '') }
  let!(:category1) { create(:category) }
  let!(:category2) { create(:category) }
  let!(:book1) { create(:book, name: 'aaa', category: category1, price: 2) }
  let!(:book2) { create(:book, name: 'zzz', category: category2, price: 1) }
  let!(:book3) { create(:book, name: 'azaz', category: category2, price: 1) }
  let(:books) { Book.all }
  let(:categories) { Category.all }

  describe 'get data from db' do
    it 'get books' do
      expect(catalog.books).to eq(books)
    end

    it 'get categories' do
      expect(catalog.categories).to eq(categories)
    end
  end

  describe 'carousel' do
    it 'return books' do
      expect(catalog.carousel_newest_books).to eq(books.last(3))
    end
  end

  describe 'count by category' do
    it 'show number of books' do
      expect(catalog.books_by_category_count(category2)).to eq(2)
    end
  end
end
