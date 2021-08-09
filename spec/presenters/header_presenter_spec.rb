RSpec.describe HeaderPresenter do
  let(:header) { described_class.new }
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
