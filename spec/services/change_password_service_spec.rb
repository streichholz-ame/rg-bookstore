require 'rails_helper'

RSpec.describe ChangePasswordService do 
  let(:user) { create(:user) }
  let(:new_password) { FFaker::Lorem.word }
  let(:another_password) { FFaker::Lorem.word }
  let(:success_params) { { old_password: user.password, new_password: new_password, confirm_password: new_password } }
  let(:not_success_params) { { old_password: user.password, new_password: new_password, confirm_password: another_password } }


  context 'when password valid' do 
    let(:change_password) {described_class.new(user, success_params)}
    
    it 'change password' do
      expect{ change_password.call }.to change{user.password}.from(user.password).to(new_password)
    end
  end

  context 'when password not valid' do
    let(:change_password) {described_class.new(user, not_success_params)}
    
    it 'change password' do
      expect(change_password.call).to eq(nil)
    end
  end
end