require 'rails_helper'

RSpec.describe 'Log In', type: :feature do
  let(:user) { create(:user) }
  let(:error_message) { 'Invalid Email or password' }
  let(:incorrect_email) { 'email@k.com' }
  let(:incorrect_password) { 'pass' }

  before { visit(new_user_session_path) }

  scenario 'when log in with empty fields' do
    fill_in 'user[email]', with: ''
    fill_in 'user[password]', with: ''
    click_on('sign-in-btn')
    expect(page).to have_content(error_message)
  end

  scenario 'when log in with empty email' do
    fill_in 'user[email]', with: ''
    fill_in 'user[password]', with: user.password
    click_on('sign-in-btn')
    expect(page).to have_content(error_message)
  end

  scenario 'when log in with empty password' do
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: ''
    click_on('sign-in-btn')
    expect(page).to have_content(error_message)
  end

  scenario 'when log in with incorrect email' do
    fill_in 'user[email]', with: incorrect_email
    fill_in 'user[password]', with: user.password
    click_on('sign-in-btn')
    expect(page).to have_content(error_message)
  end

  scenario 'when log in with incorrect password' do
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: incorrect_password
    click_on('sign-in-btn')
    expect(page).to have_content(error_message)
  end

  scenario 'when click forgot password' do
    find('a', text: I18n.t('authorization.forgot_password')).click
    expect(page).to have_current_path new_user_password_path
  end

  scenario 'when log in with correct fields' do
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_on('sign-in-btn')
    expect(page).to have_selector 'a', text: I18n.t('header.my_account')
  end
end
