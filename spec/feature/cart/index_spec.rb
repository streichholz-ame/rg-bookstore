require 'rails_helper'

describe 'Cart Page', type: :feature do
  let!(:book) { create(:book) }

  describe 'when no order items' do
    it 'show message' do
      visit carts_path
      expect(page).to have_content(I18n.t('cart.coupon_when_no_items'))
    end
  end

  describe 'order exist' do
    let!(:coupon) { create(:coupon) }
    let(:incorrect_coupon) { '11111' }
    before do
      visit catalog_index_path
      find('img').hover
      find('button[type="submit"]').click
      visit carts_path
    end

    scenario 'update item count' do
      click_on(class: 'input-link cart-plus')
      expect(page).to have_current_path(carts_path)
      sleep 1
      expect(find_field('book_count').value).to eq '2'
    end

    scenario 'delete item' do
      click_on(class: 'close general-cart-close')
      expect(page).to have_content(I18n.t('cart.deleted'))
      expect(page).to have_content(I18n.t('cart.coupon_when_no_items'))
    end

    scenario 'coupon not valid' do
      fill_in 'number', with: incorrect_coupon
      click_on(I18n.t('cart.apply_coupon'))
      expect(page).to have_content(I18n.t('cart.coupon_error'))
    end

    scenario 'coupon valid' do
      fill_in 'number', with: coupon.number
      click_on(I18n.t('cart.apply_coupon'))
      expect(page).to have_content(I18n.t('cart.coupon_used'))
    end
  end
end
