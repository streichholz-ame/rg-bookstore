require 'rails_helper'

describe 'Privacy Settings Page', type: :feature do
  let(:user) { create(:user) }

  before :each do
    login_as(user)
    visit(settings_path)
    click_on('a', text: I18n.t('account_settings.privacy'))
  end

  context 'when change email' do
    let(:error_flash_message) { I18n.t('flash.change_email_error') }
    let(:success_flash_message) { I18n.t('flash.change_email_success') }
    let(:another_email) { FFaker::Internet.email }

    scenario 'successfully' do
      fill_in 'email', with: another_email
      find('input[type="submit"][name="submit-email"]').click
      expect(page).to have_content success_flash_message
    end

    scenario 'with error' do
      fill_in 'email', with: ''
      find('input[type="submit"][name="submit-email"]').click
      expect(page).to have_content error_flash_message
    end
  end

  context 'when change password' do
    let(:another_password) { FFaker::Internet.password }
    let(:another_password2) { FFaker::Internet.password }
    let(:error_flash_message) { I18n.t('flash.change_password_error') }
    let(:success_flash_message) { I18n.t('flash.change_password_success') }

    scenario 'successfully' do
      fill_in 'old_password', with: user.password
      fill_in 'new_password', with: another_password
      fill_in 'confirm_password', with: another_password
      find('input[type="submit"][name="submit-password"]').click
      expect(page).to have_content success_flash_message
    end

    scenario 'wrong old password' do
      fill_in 'old_password', with: another_password2
      fill_in 'new_password', with: another_password
      fill_in 'confirm_password', with: another_password
      find('input[type="submit"][name="submit-password"]').click
      expect(page).to have_content error_flash_message
    end

    scenario 'wrong confirmation password' do
      fill_in 'old_password', with: user.password
      fill_in 'new_password', with: another_password
      fill_in 'confirm_password', with: another_password2
      find('input[type="submit"][name="submit-password"]').click
      expect(page).to have_content error_flash_message
    end
  end

  context 'when destroy account' do
    let(:destroy_account_btn) { I18n.t('account_settings.settings.remove_account.request') }
    let(:success_flash_message) { I18n.t('flash.destroy_success') }

    scenario 'successfully' do
      find('span', class: 'checkbox-icon').click
      click_on(destroy_account_btn)
      expect(page).to have_content success_flash_message
    end
  end
end
