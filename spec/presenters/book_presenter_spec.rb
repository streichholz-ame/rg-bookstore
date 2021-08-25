require 'rails_helper'

RSpec.describe BookPresenter do
  let(:book) { create(:book, :with_author, description: FFaker::Lorem.paragraphs) }
  let(:book_presenter) { described_class.new(book) }
  let(:dimensions_line) { "H: #{book.height}\" x W: #{book.width}\" x D: #{book.depth}" }

  describe 'description' do
    it 'shortened' do
      expect(book_presenter.description.length).to eq(250)
    end

    it 'full' do
      expect(book_presenter.full_description.length).to eq(book.description.length)
    end
  end

  describe 'dimentions' do
    it 'return string' do
      expect(book_presenter.dimensions).to eq(dimensions_line)
    end
  end

  describe 'author' do
    it 'return book author' do
      expect(book_presenter.author_name).to eq(book.authors.map(&:name).join(', '))
    end
  end
end
