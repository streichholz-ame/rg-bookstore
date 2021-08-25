require 'rails_helper'

RSpec.describe SortingService do
  let(:category) { create(:category) }
  let!(:book1) { create(:book, name: 'aaa', category: category, price: 2) }
  let!(:book2) { create(:book, name: 'zzz', category: category, price: 1) }
  let(:books) { Book.all }

  let(:title_asc) { { sort: :title_asc, id: category.id } }
  let(:title_desc) { { sort: :title_desc, id: category.id } }
  let(:price_asc) { { sort: :price_asc, id: category.id } }
  let(:price_desc) { { sort: :price_desc, id: category.id } }
  let(:newest) { { sort: :newest, id: category.id } }

  describe 'sort by title asc' do
    let(:sorting_service) { described_class.new(books, title_asc) }

    it 'sort books' do
      expect(sorting_service.call).to eq([book1, book2])
    end
  end

  describe 'sort by title_desc' do
    let(:sorting_service) { described_class.new(books, title_desc) }

    it 'sort books' do
      expect(sorting_service.call).to eq([book2, book1])
    end
  end

  describe 'sort by price_asc' do
    let(:sorting_service) { described_class.new(books, price_asc) }

    it 'sort books' do
      expect(sorting_service.call).to eq([book2, book1])
    end
  end

  describe 'sort by price_desc' do
    let(:sorting_service) { described_class.new(books, price_desc) }

    it 'sort books' do
      expect(sorting_service.call).to eq([book1, book2])
    end
  end

  describe 'sort by newest' do
    let(:sorting_service) { described_class.new(books, newest) }

    it 'sort books' do
      expect(sorting_service.call).to eq([book2, book1])
    end
  end
end
