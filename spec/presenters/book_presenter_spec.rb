require 'rails_helper'

RSpec.describe BookPresenter do
  let!(:book1) { create(:book, name: 'aaa', price: 2, description: FFaker::Lorem.paragraphs) }
  let(:book_presenter) { described_class.new(book1) }
  let(:dimensions_line) { "H: #{book1.height}\" x W: #{book1.width}\" x D: #{book1.depth}" }

  describe 'description' do
    it 'shortened' do
      expect(book_presenter.description.length).to eq(250)
    end

    it 'shortened' do
      expect(book_presenter.full_description.length).to be > 250
    end
  end

  describe 'dimentions' do
    it 'return string' do
      expect(book_presenter.dimensions).to eq(dimensions_line)
    end
  end
end
