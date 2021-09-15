require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  context 'with database columns' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:number).of_type(:string) }
    it { is_expected.to have_db_column(:date).of_type(:string) }
    it { is_expected.to have_db_column(:cvv).of_type(:string) }
  end

  context 'with associations' do
    it { is_expected.to have_one(:order) }
  end
end
