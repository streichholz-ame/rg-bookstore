require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  context 'with database columns' do
    it { is_expected.to have_db_column(:quantity).of_type(:integer) }
    it { is_expected.to have_db_index(:order_id) }
    it { is_expected.to have_db_index(:book_id) }
  end

  context 'with associations' do
    it { is_expected.to belong_to(:order) }
    it { is_expected.to belong_to(:book) }
  end
end
