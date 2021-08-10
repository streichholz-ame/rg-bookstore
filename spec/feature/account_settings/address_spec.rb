require 'rails_helper'

RSpec.describe 'Address Settings Page', type: :feature do
  let!(:user) { create(:user) }

  before :each do
    login_as(user)
    visit(edit_address_path(user))
  end

  context 'shipping address' do
    let(:shipping_address) { create(:shipping_address, addressable: user) }
    let(:other_shipping_address) { create(:shipping_address, addressable: user) }
    let(:empty_field_message) { "can't be blank" }
    let(:address_attributes) { attributes_for(:shipping_address) }
    let(:change_address_attributes) { attributes_for(:shipping_address) }

    scenario 'empty fields' do
      within('form#ShippingAddress') do
        find('input[type="submit"]').click
        expect(page).to have_content empty_field_message
      end
    end

    scenario 'create new address' do
      within('form#ShippingAddress') do
        fill_in 'address_form_first_name', with: address_attributes[:first_name]
        fill_in 'address_form_last_name', with: address_attributes[:last_name]
        fill_in 'address_form_address', with: address_attributes[:address]
        fill_in 'address_form_city', with: address_attributes[:city]
        fill_in 'address_form_zip', with: address_attributes[:zip]
        fill_in 'address_form_country', with: address_attributes[:country]
        fill_in 'address_form_phone', with: address_attributes[:phone]
        find('input[type="submit"]').click
      end
      expect(Address.count).to eq(1)
    end

    context 'when address exist' do
      before do
        user.addresses << shipping_address
        visit(edit_address_path(user))
      end

      scenario 'edit existing address' do
        within('form#ShippingAddress') do
          fill_in 'address_form_first_name', with: change_address_attributes[:first_name]
          fill_in 'address_form_last_name', with: change_address_attributes[:last_name]
          fill_in 'address_form_address', with: change_address_attributes[:address]
          fill_in 'address_form_city', with: change_address_attributes[:city]
          fill_in 'address_form_zip', with: change_address_attributes[:zip]
          fill_in 'address_form_country', with: change_address_attributes[:country]
          fill_in 'address_form_phone', with: change_address_attributes[:phone]
          find('input[type="submit"]').click
        end
        expect(user.shipping_address[:first_name]).to eq(change_address_attributes[:first_name])
      end

      scenario 'fields are filled' do
        within('form#ShippingAddress') do
          expect(page).to have_field 'address_form[first_name]', with: shipping_address[:first_name]
          expect(page).to have_field 'address_form[last_name]', with: shipping_address[:last_name]
          expect(page).to have_field 'address_form[address]', with: shipping_address[:address]
          expect(page).to have_field 'address_form[city]', with: shipping_address[:city]
          expect(page).to have_field 'address_form[zip]', with: shipping_address[:zip]
          expect(page).to have_field 'address_form[country]', with: shipping_address[:country]
          expect(page).to have_field 'address_form[phone]', with: shipping_address[:phone]
        end
      end
    end

    scenario 'when fields are empty' do
      within('form#ShippingAddress') do
        expect(page).to have_field 'address_form[first_name]', with: ''
        expect(page).to have_field 'address_form[last_name]', with: ''
        expect(page).to have_field 'address_form[address]', with: ''
        expect(page).to have_field 'address_form[city]', with: ''
        expect(page).to have_field 'address_form[zip]', with: ''
        expect(page).to have_field 'address_form[country]', with: ''
        expect(page).to have_field 'address_form[phone]', with: ''
      end
    end
  end

  context 'billing address' do
    let(:billing_address) { create(:billing_address, addressable: user) }
    let(:other_billing_address) { create(:billing_address, addressable: user) }
    let(:empty_field_message) { "can't be blank" }
    let(:address_attributes) { attributes_for(:billing_address) }
    let(:change_address_attributes) { attributes_for(:billing_address) }

    scenario 'empty fields' do
      within('form#BillingAddress') do
        find('input[type="submit"]').click
        expect(page).to have_content empty_field_message
      end
    end

    scenario 'create new address' do
      within('form#BillingAddress') do
        fill_in 'address_form_first_name', with: address_attributes[:first_name]
        fill_in 'address_form_last_name', with: address_attributes[:last_name]
        fill_in 'address_form_address', with: address_attributes[:address]
        fill_in 'address_form_city', with: address_attributes[:city]
        fill_in 'address_form_zip', with: address_attributes[:zip]
        fill_in 'address_form_country', with: address_attributes[:country]
        fill_in 'address_form_phone', with: address_attributes[:phone]
        find('input[type="submit"]').click
      end
      expect(Address.count).to eq(1)
    end

    context 'when address exist' do
      before do
        user.addresses << billing_address
        visit(edit_address_path(user))
      end

      scenario 'edit existing address' do
        within('form#BillingAddress') do
          fill_in 'address_form_first_name', with: change_address_attributes[:first_name]
          fill_in 'address_form_last_name', with: change_address_attributes[:last_name]
          fill_in 'address_form_address', with: change_address_attributes[:address]
          fill_in 'address_form_city', with: change_address_attributes[:city]
          fill_in 'address_form_zip', with: change_address_attributes[:zip]
          fill_in 'address_form_country', with: change_address_attributes[:country]
          fill_in 'address_form_phone', with: change_address_attributes[:phone]
          find('input[type="submit"]').click
        end
        expect(user.billing_address[:first_name]).to eq(change_address_attributes[:first_name])
      end

      scenario 'fields are filled' do
        within('form#BillingAddress') do
          expect(page).to have_field 'address_form[first_name]', with: billing_address[:first_name]
          expect(page).to have_field 'address_form[last_name]', with: billing_address[:last_name]
          expect(page).to have_field 'address_form[address]', with: billing_address[:address]
          expect(page).to have_field 'address_form[city]', with: billing_address[:city]
          expect(page).to have_field 'address_form[zip]', with: billing_address[:zip]
          expect(page).to have_field 'address_form[country]', with: billing_address[:country]
          expect(page).to have_field 'address_form[phone]', with: billing_address[:phone]
        end
      end
    end

    scenario 'when fields are empty' do
      within('form#BillingAddress') do
        expect(page).to have_field 'address_form[first_name]', with: ''
        expect(page).to have_field 'address_form[last_name]', with: ''
        expect(page).to have_field 'address_form[address]', with: ''
        expect(page).to have_field 'address_form[city]', with: ''
        expect(page).to have_field 'address_form[zip]', with: ''
        expect(page).to have_field 'address_form[country]', with: ''
        expect(page).to have_field 'address_form[phone]', with: ''
      end
    end
  end
end
