require 'rails_helper'

RSpec.describe CatalogPresenter do
  let(:catalog) { described_class.new(books) }
  let!(:category1) { create(:category) }
  let!(:category2) { create(:category) }
  let!(:book1) { create(:book, :with_author, category: category1) }
  let!(:book2) { create(:book, :with_author, category: category2) }
  let!(:book3) { create(:book, :with_author, category: category2) }
  let(:books) { Book.all }
  let(:categories) { Category.all }

  describe 'get data from db' do
    it 'get books' do
      expect(catalog.size).to eq(books.size)
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

  describe 'author_name' do
    let(:author_names) do
      book1.authors.map do |author|
        "#{author.first_name}" "#{author.last_name}"
      end
    end
    it 'return book author' do
      expect(catalog.author_name(book1)).to eq(author_names.map { |author| author }.join(', '))
    end
  end
end
