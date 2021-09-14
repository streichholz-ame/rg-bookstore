require 'rails_helper'

describe 'Address Page', type: :feature do
  let!(:user) { create(:user) }
  let!(:order) { create(:order, :with_item, user_id: user.id) }

  before { login_as(user) }

  context 'when addresses empty' do
    before { visit(checkout_index_path) }
    scenario 'when billing fields are empty' do
      within('#billing-form') do
        expect(page).to have_field 'order[billing_address][first_name]', with: ''
        expect(page).to have_field 'order[billing_address][last_name]', with: ''
        expect(page).to have_field 'order[billing_address][address]', with: ''
        expect(page).to have_field 'order[billing_address][city]', with: ''
        expect(page).to have_field 'order[billing_address][zip]', with: ''
        expect(page).to have_field 'order[billing_address][country]', with: ''
        expect(page).to have_field 'order[billing_address][phone]', with: ''
      end
    end

    scenario 'when shipping fields are empty' do
      within('#shipping-form') do
        expect(page).to have_field 'order[shipping_address][first_name]', with: ''
        expect(page).to have_field 'order[shipping_address][last_name]', with: ''
        expect(page).to have_field 'order[shipping_address][address]', with: ''
        expect(page).to have_field 'order[shipping_address][city]', with: ''
        expect(page).to have_field 'order[shipping_address][zip]', with: ''
        expect(page).to have_field 'order[shipping_address][country]', with: ''
        expect(page).to have_field 'order[shipping_address][phone]', with: ''
      end
    end
  end

  context 'create new addresses' do
    scenario 'create only billing_address' do
      visit(checkout_index_path)
      within('#billing-form') do
        fill_in 'order_billing_address_first_name', with: order.address[:first_name]
        fill_in 'order_billing_address_last_name', with: order.address[:last_name]
        fill_in 'order_billing_address_address', with: order.address[:address]
        fill_in 'order_billing_address_city', with: order.address[:city]
        fill_in 'order_billing_address_zip', with: order.address[:zip]
        fill_in 'order_billing_address_country', with: order.address[:country]
        fill_in 'order_billing_address_phone', with: order.address[:phone]
      end
      find('label', class: 'checkbox-label').click
      find('input[type="submit"]').click
      expect(page).to have_current_path checkout_path(:delivery)
    end
  end

  context 'when user has addresses' do
    let!(:shipping_address) { create(:shipping_address, addressable: user) }
    let!(:billing_address) { create(:billing_address, addressable: user) }
    let(:empty_field_message) { "can't be blank" }

    before { visit(checkout_index_path) }

    scenario 'billing address filled' do
      within('#billing-form') do
        expect(page).to have_field 'order[billing_address][first_name]', with: billing_address[:first_name]
        expect(page).to have_field 'order[billing_address][last_name]', with: billing_address[:last_name]
        expect(page).to have_field 'order[billing_address][address]', with: billing_address[:address]
        expect(page).to have_field 'order[billing_address][city]', with: billing_address[:city]
        expect(page).to have_field 'order[billing_address][zip]', with: billing_address[:zip]
        expect(page).to have_field 'order[billing_address][country]', with: billing_address[:country]
        expect(page).to have_field 'order[billing_address][phone]', with: billing_address[:phone]
      end
    end

    scenario 'shipping address filled' do
      within('#shipping-form') do
        expect(page).to have_field 'order[shipping_address][first_name]', with: shipping_address[:first_name]
        expect(page).to have_field 'order[shipping_address][last_name]', with: shipping_address[:last_name]
        expect(page).to have_field 'order[shipping_address][address]', with: shipping_address[:address]
        expect(page).to have_field 'order[shipping_address][city]', with: shipping_address[:city]
        expect(page).to have_field 'order[shipping_address][zip]', with: shipping_address[:zip]
        expect(page).to have_field 'order[shipping_address][country]', with: shipping_address[:country]
        expect(page).to have_field 'order[shipping_address][phone]', with: shipping_address[:phone]
      end
    end
  end
end
