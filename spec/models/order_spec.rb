require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'with database columns' do
    it { is_expected.to have_db_column(:status).of_type(:string) }
    it { is_expected.to have_db_column(:number).of_type(:string) }
    it { is_expected.to have_db_index(:user_id) }
    it { is_expected.to have_db_index(:coupon_id) }
    it { is_expected.to have_db_index(:address_id) }
    it { is_expected.to have_db_index(:credit_card_id) }
    it { is_expected.to have_db_index(:delivery_id) }
  end

  context 'with associations' do
    it { is_expected.to have_many(:order_items).dependent(:destroy) }
    it { is_expected.to belong_to(:user).optional(true) }
    it { is_expected.to belong_to(:coupon).optional(true) }
    it { is_expected.to belong_to(:delivery).optional(true) }
    it { is_expected.to belong_to(:credit_card).optional(true) }
  end
end
