require 'rails_helper'

describe 'Address Page', type: :feature do
  let!(:user) { create(:user) }
  let!(:order) { create(:order, :with_item, :with_credit_card, user_id: user.id) }
  let(:address) { Address.find_by(order_id: order.id) }
  let!(:delivery) { create(:delivery) }

  before { login_as(user) }
  context 'full checkout path' do
    before { visit(checkout_index_path) }
    it 'go through all steps' do
      within('#billing-form') do
        fill_in 'order_address_form_first_name', with: address[:first_name]
        fill_in 'order_address_form_last_name', with: address[:last_name]
        fill_in 'order_address_form_address', with: address[:address]
        fill_in 'order_address_form_city', with: address[:city]
        fill_in 'order_address_form_zip', with: address[:zip]
        fill_in 'order_address_form_country', with: address[:country]
        fill_in 'order_address_form_phone', with: address[:phone]
      end
      within('#shipping-form') do
        fill_in 'order_address_form_first_name', with: address[:first_name]
        fill_in 'order_address_form_last_name', with: address[:last_name]
        fill_in 'order_address_form_address', with: address[:address]
        fill_in 'order_address_form_city', with: address[:city]
        fill_in 'order_address_form_zip', with: address[:zip]
        fill_in 'order_address_form_country', with: address[:country]
        fill_in 'order_address_form_phone', with: address[:phone]
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
      expect(page).to have_content address.first_name
      expect(page).to have_content delivery.name
      expect(page).to have_content order.credit_card.number.last(4)

      click_on I18n.t('checkout.confirm.place_order')

      expect(page).to have_current_path checkout_path(:complete)

      click_on I18n.t('checkout.complete.back_to_store')
      expect(page).to have_current_path catalog_index_path
    end
  end
end
