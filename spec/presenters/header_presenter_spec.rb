require 'rails_helper'

RSpec.describe HeaderPresenter do
  let(:header) { described_class.new(order) }
  let(:order) { create(:order) }
  let!(:category1) { create(:category) }
  let!(:category2) { create(:category) }
  let!(:category2) { create(:category) }
  let(:categories) { Category.all }

  describe 'get data from db' do
    it 'get categories' do
      expect(header.categories).to eq(categories)
    end
  end
end
