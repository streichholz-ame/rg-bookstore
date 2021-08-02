require 'rails_helper'

describe 'Privacy Settings Page', type: :feature do
  let(:user) { create(:user) }
  let(:another_password) { FFaker::Internet.password }

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
    scenario 'successfully' do
      
    end
  end
end