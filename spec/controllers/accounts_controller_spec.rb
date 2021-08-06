require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  let(:user) { create(:user) }

  describe 'DELETE #destroy' do
    before { login_as(user) }

    it 'successfully' do
      allow(subject).to receive(:current_user).and_return(user)
      delete :destroy, params: { id: user.id }
      expect(subject).to set_flash[:success]
    end

    describe 'failing' do
      before { allow(subject).to receive(:current_user).and_return(nil) }

      it 'failed' do
        delete :destroy, params: { id: '' }
        expect(subject).to set_flash[:error]
      end
    end
  end

  describe 'PUT #update' do
    let(:valid_attributes) { attributes_for(:user) }

    before do
      login_as(user)
      allow(subject).to receive(:current_user).and_return(user)
    end

    it 'successfully' do
      put :update,
          params: { id: user.id, old_password: user.password, new_password: user.password,
                    confirm_password: user.password }
      expect(subject).to set_flash[:success]
    end

    it 'failed' do
      put :update,
          params: { id: user.id, old_password: user.password, new_password: valid_attributes[:password],
                    confirm_password: user.password }
      expect(subject).to set_flash[:error]
    end
  end
end
