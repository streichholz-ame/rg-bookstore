require 'rails_helper'

RSpec.describe Role, type: :model do
  context 'with database columns' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:resource_type).of_type(:string) }
    it { is_expected.to have_db_column(:resource_id).of_type(:integer) }
  end

  context 'with associations' do
    it { is_expected.to have_and_belong_to_many(:users) }
  end
end
