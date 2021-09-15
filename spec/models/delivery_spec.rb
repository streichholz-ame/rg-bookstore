require 'rails_helper'

RSpec.describe Delivery, type: :model do
  context 'with database columns' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:price).of_type(:decimal) }
    it { is_expected.to have_db_column(:days_min).of_type(:integer) }
    it { is_expected.to have_db_column(:days_max).of_type(:integer) }
  end

  context 'with associations' do
    it { is_expected.to have_many(:orders) }
  end
end
