require 'rails_helper'

RSpec.describe Coupon, type: :model do
  context 'with database columns' do
    it { is_expected.to have_db_column(:number).of_type(:string) }
    it { is_expected.to have_db_column(:discount).of_type(:decimal) }
  end

  context 'with associations' do
    it { is_expected.to have_many(:orders).dependent(:nullify) }
  end
end
