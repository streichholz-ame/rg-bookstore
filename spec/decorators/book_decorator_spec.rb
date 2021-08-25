require 'rails_helper'

RSpec.describe BookDecorator do
  let(:book) { create(:book, :with_author, description: FFaker::Lorem.paragraphs) }
  let(:book_decorator) { described_class.new(book).decorate }
  let(:dimensions) do
    I18n.t('book_page.dimentions_description', height: book.height, width: book.width,
                                               depth: book.depth)
  end

  describe 'description' do
    it 'shortened' do
      expect(book_decorator.description.length).to eq(250)
    end

    it 'full' do
      expect(book_decorator.full_description.length).to eq(book.description.length)
    end
  end

  describe 'dimentions' do
    it 'return string' do
      expect(book_decorator.dimensions).to eq(dimensions)
    end
  end

  describe 'author' do
    let(:author_names) do
      book.authors.map do |author|
        "#{author.first_name}" "#{author.last_name}"
      end
    end
    it 'return book author' do
      expect(book_decorator.author_name).to eq(author_names.map { |author| author }.join(', '))
    end
  end
end
