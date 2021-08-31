require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'with database columns' do
    it { is_expected.to have_db_index(:user_id) }
    it { is_expected.to have_db_index(:coupon_id) }
    it { is_expected.to have_db_column(:status).of_type(:integer) }
    it { is_expected.to have_db_column(:number).of_type(:string) }
  end

  context 'with associations' do
    it { is_expected.to have_many(:order_items).dependent(:destroy) }
  end
end
