require 'rails_helper'

RSpec.describe 'Admin book Page', type: feature do
  let!(:admin) { create(:admin_user) }
  let!(:review) { create(:review) }

  before do
    login_as(admin, scope: :admin_user)
    visit admin_reviews_path
  end

  context 'change_status' do
    scenario 'approved' do
      click_on('Approve')
      click_on('Published')
      expect(page).to have_content(review.review_text)
    end

    scenario 'refected' do
      click_on('Reject')
      click_on('Rejected')
      expect(page).to have_content(review.review_text)
    end
  end
end
