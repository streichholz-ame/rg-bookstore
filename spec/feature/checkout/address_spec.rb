require 'rails_helper'

describe 'Address Page', type: :feature do
  let!(:user) { create(:user) }
  let!(:order) { create(:order, :with_item, user_id: user.id) }

  before { login_as(user) }

  context 'when addresses empty' do
    before { visit(checkout_index_path) }
    scenario 'when billing fields are empty' do
      within('#billing-form') do
        expect(page).to have_field 'order[address_form][first_name]', with: ''
        expect(page).to have_field 'order[address_form][last_name]', with: ''
        expect(page).to have_field 'order[address_form][address]', with: ''
        expect(page).to have_field 'order[address_form][city]', with: ''
        expect(page).to have_field 'order[address_form][zip]', with: ''
        expect(page).to have_field 'order[address_form][country]', with: ''
        expect(page).to have_field 'order[address_form][phone]', with: ''
      end
    end

    scenario 'when shipping fields are empty' do
      within('#shipping-form') do
        expect(page).to have_field 'order[address_form][first_name]', with: ''
        expect(page).to have_field 'order[address_form][last_name]', with: ''
        expect(page).to have_field 'order[address_form][address]', with: ''
        expect(page).to have_field 'order[address_form][city]', with: ''
        expect(page).to have_field 'order[address_form][zip]', with: ''
        expect(page).to have_field 'order[address_form][country]', with: ''
        expect(page).to have_field 'order[address_form][phone]', with: ''
      end
    end
  end

  context 'create new addresses' do
    scenario 'create only billing_address' do
      visit(checkout_index_path)
      within('#billing-form') do
        fill_in 'order_address_form_first_name', with: order.address[:first_name]
        fill_in 'order_address_form_last_name', with: order.address[:last_name]
        fill_in 'order_address_form_address', with: order.address[:address]
        fill_in 'order_address_form_city', with: order.address[:city]
        fill_in 'order_address_form_zip', with: order.address[:zip]
        fill_in 'order_address_form_country', with: order.address[:country]
        fill_in 'order_address_form_phone', with: order.address[:phone]
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
        expect(page).to have_field 'order[address_form][first_name]', with: billing_address[:first_name]
        expect(page).to have_field 'order[address_form][last_name]', with: billing_address[:last_name]
        expect(page).to have_field 'order[address_form][address]', with: billing_address[:address]
        expect(page).to have_field 'order[address_form][city]', with: billing_address[:city]
        expect(page).to have_field 'order[address_form][zip]', with: billing_address[:zip]
        expect(page).to have_field 'order[address_form][country]', with: billing_address[:country]
        expect(page).to have_field 'order[address_form][phone]', with: billing_address[:phone]
      end
    end

    scenario 'shipping address filled' do
      within('#shipping-form') do
        expect(page).to have_field 'order[address_form][first_name]', with: shipping_address[:first_name]
        expect(page).to have_field 'order[address_form][last_name]', with: shipping_address[:last_name]
        expect(page).to have_field 'order[address_form][address]', with: shipping_address[:address]
        expect(page).to have_field 'order[address_form][city]', with: shipping_address[:city]
        expect(page).to have_field 'order[address_form][zip]', with: shipping_address[:zip]
        expect(page).to have_field 'order[address_form][country]', with: shipping_address[:country]
        expect(page).to have_field 'order[address_form][phone]', with: shipping_address[:phone]
      end
    end
  end
end
