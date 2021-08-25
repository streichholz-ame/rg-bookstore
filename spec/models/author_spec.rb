require 'rails_helper'

RSpec.describe Author, type: :model do
  context 'with database columns' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
  end

  context 'with assosiations' do
    it { is_expected.to have_many(:book_authors).dependent(:destroy) }
    it { is_expected.to have_many(:books).through(:book_authors) }
  end
end
