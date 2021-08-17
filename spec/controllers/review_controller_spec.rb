require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let!(:book) { create(:book) }
  let!(:user) { create(:user) }
  let(:review) { create(:review) }
  let(:uncorrect_review) { create(:review, title: '') }

  context 'POST #create' do
    before do
      login_as(user)
      allow(subject).to receive(:current_user).and_return(user)
    end

    it 'successfully' do
      post :create, params: { book_id: book.id, review: review.attributes }
      expect(subject).to set_flash[:success]
    end

    it 'fails' do
      post :create, params: { book_id: book.id, review: uncorrect_review.attributes }
      expect(subject).to set_flash[:error]
    end
  end
end
