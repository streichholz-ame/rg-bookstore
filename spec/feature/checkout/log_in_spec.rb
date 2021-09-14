require 'rails_helper'

describe 'Log In Page', type: :feature do
  let(:user) { create(:user) }
  let!(:book) { create(:book, :with_author) }
  let(:new_user_email) { FFaker::Internet.email }

  before do
    visit(catalog_index_path)
    find('img').hover
    find('button[type="submit"]').click
  end
  scenario 'when user has account' do
    visit carts_path
    click_on(I18n.t('cart.checkout'))
    within '#checkout-log-in' do
      fill_in 'email', with: user.email
      fill_in 'password', with: user.password
    end
    click_on(I18n.t('checkout.log_in.authorization'))
    expect(page).to have_content I18n.t('devise.sessions.signed_in')
  end
  scenario ' when user has no account' do
    visit carts_path
    click_on(I18n.t('cart.checkout'))
    within '#checkout-register' do
      fill_in 'email', with: new_user_email
    end
    click_on(I18n.t('checkout.log_in.registration'))
    expect(page).to have_content I18n.t('devise.registrations.signed_up')
  end
end
