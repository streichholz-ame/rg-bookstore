require 'rails_helper'

RSpec.describe Address, type: :model do
  context 'with database columns' do
    it { is_expected.to have_db_column(:first_name).of_type(:string) }
    it { is_expected.to have_db_column(:last_name).of_type(:string) }
    it { is_expected.to have_db_column(:address).of_type(:string) }
    it { is_expected.to have_db_column(:city).of_type(:string) }
    it { is_expected.to have_db_column(:zip).of_type(:integer) }
    it { is_expected.to have_db_column(:country).of_type(:string) }
    it { is_expected.to have_db_column(:phone).of_type(:string) }
    it { is_expected.to have_db_column(:type).of_type(:string) }
    it { is_expected.to have_db_column(:addressable_id).of_type(:integer) }
    it { is_expected.to have_db_column(:addressable_type).of_type(:string) }
  end

  context 'with assosiations' do
    it { is_expected.to belong_to(:addressable) }
  end
end