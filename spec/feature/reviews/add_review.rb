require 'rails_helper'

RSpec.describe 'Add Review', type: :feature do
  let(:book) { create(:book) }
  let(:book_without_reviews) { create(:book) }
  let(:review) { create(:review, book: book) }
  let!(:review) { create(:review, book: book, status: 'published') }

  scenario 'no reviews' do
    visit book_path(book_without_reviews)
    expect(page).to have_content(I18n.t('book_page.no_reviews'))
  end

  context 'when user logged in' do
    let(:user) { create(:user) }
    let(:empty_field_message) { "Review text can't be blank" }

    before do
      login_as user
      visit book_path(book.id)
    end
    scenario 'user can see reviews' do
      expect(page).to have_content(review.review_text)
    end
    scenario 'user add review with empty field' do
      within('form#new_review') do
        first('label', class: 'book-rating').click
        fill_in 'review_title', with: review[:title]
        fill_in 'review_review_text', with: ''
        find('input[type="submit"]').click
      end
      page.should have_selector '.alert', text: empty_field_message
    end
    scenario 'user add review with correct fields' do
      within('form#new_review') do
        first('label', class: 'book-rating').click
        fill_in 'review_title', with: review[:title]
        fill_in 'review_review_text', with: review[:review_text]
        find('input[type="submit"]').click
      end
      page.should have_selector '.alert', text: I18n.t('flash.review')
    end
  end

  context 'when guest' do
    before { visit book_path(book.id) }

    scenario 'guest can see reviews' do
      expect(page).to have_content(review.review_text)
    end
    scenario 'guest cannot add review' do
      expect(page).to have_content(I18n.t('book_page.not_authorized'))
    end
  end
end
