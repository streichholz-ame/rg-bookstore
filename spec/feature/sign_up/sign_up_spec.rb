require 'rails_helper'

RSpec.describe 'Sign Up', type: :feature do
  let(:valid_email) { 'test@gmail.com' }
  let(:invalid_email) { 'test' }
  let(:valid_password) { 'password' }
  let(:short_password) { 'pass' }

  before { visit(new_user_registration_path) }

  scenario 'sign up with empty fields' do
    fill_in 'user[email]', with: ''
    fill_in 'user[password]', with: ''
    fill_in 'user[password_confirmation]', with: ''
    click_on('sign-up-btn')
    expect(page).to have_content("can't be blank")
  end

  scenario 'sign up with empty password' do
    fill_in 'user[email]', with: valid_email
    fill_in 'user[password]', with: ''
    fill_in 'user[password_confirmation]', with: ''
    click_on('sign-up-btn')
    expect(page).to have_content("can't be blank")
  end

  scenario 'sign up with empty email' do
    fill_in 'user[email]', with: ''
    fill_in 'user[password]', with: valid_password
    fill_in 'user[password_confirmation]', with: valid_password
    click_on('sign-up-btn')
    expect(page).to have_content("can't be blank")
  end

  scenario 'sign up with invalid confirmation field' do
    fill_in 'user[email]', with: valid_email
    fill_in 'user[password]', with: valid_password
    fill_in 'user[password_confirmation]', with: short_password
    click_on('sign-up-btn')
    expect(page).to have_content("doesn't match Password")
  end

  scenario 'sign up with incorrect password input' do
    fill_in 'user[email]', with: valid_email
    fill_in 'user[password]', with: short_password
    fill_in 'user[password_confirmation]', with: short_password
    click_on('sign-up-btn')
    expect(page).to have_content('is too short ')
  end

  scenario 'sign up with correct input' do
    fill_in 'user[email]', with: valid_email
    fill_in 'user[password]', with: valid_password
    fill_in 'user[password_confirmation]', with: valid_password
    click_on('sign-up-btn')
    expect(page).to have_content I18n.t('devise.registrations.signed_up_but_unconfirmed')
  end

  scenario 'sign ip via facebook'
end
