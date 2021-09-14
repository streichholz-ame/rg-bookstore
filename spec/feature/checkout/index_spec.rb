require 'rails_helper'

describe 'Address Page', type: :feature do
  let!(:user) { create(:user) }
  let!(:order) { create(:order, :with_item, :with_credit_card, user_id: user.id) }
  let!(:delivery) { create(:delivery) }

  before { login_as(user) }
  context 'full checkout path' do
    before { visit(checkout_index_path) }
    it 'go through all steps' do
      within('#billing-form') do
        fill_in 'order_billing_address_first_name', with: order.address[:first_name]
        fill_in 'order_billing_address_last_name', with: order.address[:last_name]
        fill_in 'order_billing_address_address', with: order.address[:address]
        fill_in 'order_billing_address_city', with: order.address[:city]
        fill_in 'order_billing_address_zip', with: order.address[:zip]
        fill_in 'order_billing_address_country', with: order.address[:country]
        fill_in 'order_billing_address_phone', with: order.address[:phone]
      end
      within('#shipping-form') do
        fill_in 'order_shipping_address_first_name', with: order.address[:first_name]
        fill_in 'order_shipping_address_last_name', with: order.address[:last_name]
        fill_in 'order_shipping_address_address', with: order.address[:address]
        fill_in 'order_shipping_address_city', with: order.address[:city]
        fill_in 'order_shipping_address_zip', with: order.address[:zip]
        fill_in 'order_shipping_address_country', with: order.address[:country]
        fill_in 'order_shipping_address_phone', with: order.address[:phone]
      end
      find('input[type="submit"]').click

      expect(page).to have_current_path checkout_path(:delivery)

      find('label', class: 'radio-label').click
      click_on I18n.t('checkout.continue_btn')
      expect(page).to have_current_path checkout_path(:payment)

      within('#new_payment_form') do
        fill_in 'payment_form_number', with: order.credit_card.number
        fill_in 'payment_form_name', with: order.credit_card.name
        fill_in 'payment_form_date', with: order.credit_card.date
        fill_in 'payment_form_cvv', with: order.credit_card.cvv
        click_on I18n.t('checkout.continue_btn')
      end
      expect(page).to have_current_path checkout_path(:confirm)
      expect(page).to have_content order.address.first_name
      expect(page).to have_content delivery.name
      expect(page).to have_content order.credit_card.number.last(4)

      click_on I18n.t('confirm.place_order')

      expect(page).to have_current_path checkout_path(:complete)

      click_on I18n.t('checkout.complete.back_to_store')
      expect(page).to have_current_path catalog_index_path
    end
  end
end
