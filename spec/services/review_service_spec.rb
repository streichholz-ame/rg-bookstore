require 'rails_helper'

RSpec.describe ReviewService do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:params) { attributes_for(:review, book_id: book.id, user_id: user.id) }
  let(:review_service) { described_class.new(params) }
  it 'creates review' do
    expect { review_service.save_review }.to change { Review.count }.from(0).to(1)
  end
end
