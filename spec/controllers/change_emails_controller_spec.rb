require 'rails_helper'

RSpec.describe ChangeEmailsController, type: :controller do
  let(:user) { create(:user) }
  let(:new_email) { FFaker::Internet.email }

  describe 'change email' do
    before do
      login_as(user)
      allow(subject).to receive(:current_user).and_return(user)
    end

    it 'successfully' do
      put :update, params: { id: user.id, email: new_email }
      expect(user.email).to eq(new_email)
      expect(subject).to set_flash[:success]
    end

    it 'failed' do
      put :update, params: { id: user.id, email: '' }
      expect(subject).to set_flash[:error]
    end
  end
end
