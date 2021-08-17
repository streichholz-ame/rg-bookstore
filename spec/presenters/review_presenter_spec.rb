require 'rails_helper'

RSpec.describe ReviewPresenter do
  let!(:book) { create(:book) }
  let!(:user) { create(:user) }
  let(:review_presenter) { described_class.new(book) }
  let!(:review) { create(:review, book: book, user: user) }

  it 'return reviews' do
    expect(review_presenter.all_reviews).to eq(book.reviews)
  end
  describe '#user_name' do
    let(:user_name) { user.email.gsub(/@[a-zA-Z.]+/, '') }

    it 'return name depending on email' do
      expect(review_presenter.user_name(review)).to eq(user_name)
    end
  end

  describe '#date' do
    let(:date) { review.created_at.strftime('%_m/%d/%y')[1..] }

    it 'return date' do
      expect(review_presenter.date(review)).to eq(date)
    end
  end

  describe 'approved reviews' do
    let!(:published_review) { create(:review, status: 'published', book: book) }
    let!(:rejected_review) { create(:review, status: 'rejected', book: book) }

    it 'return only published' do
      expect(Review.count).to eq(3)
      expect(review_presenter.approved_reviews.count).to eq(1)
    end
  end
end
