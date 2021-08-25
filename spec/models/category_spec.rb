require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'with database columns' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
  end

  context 'with associations' do
    it { is_expected.to have_many(:books).dependent(:destroy) }
  end
end
