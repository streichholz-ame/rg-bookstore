require 'rails_helper'

RSpec.describe Review, type: :model do
  context 'with database columns' do
    it { is_expected.to have_db_column(:title).of_type(:string) }
    it { is_expected.to have_db_column(:review_text).of_type(:text) }
    it { is_expected.to have_db_column(:rating).of_type(:integer) }
    it { is_expected.to have_db_index(:book_id) }
    it { is_expected.to have_db_index(:user_id) }
  end

  context 'with associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:book) }
  end

  describe 'change status' do
    let(:review) { create(:review) }
    it 'approve' do
      expect { review.approve! }.to change { review.status }.from('processing').to('published')
    end

    it 'reject' do
      expect { review.reject! }.to change { review.status }.from('processing').to('rejected')
    end
  end
end
