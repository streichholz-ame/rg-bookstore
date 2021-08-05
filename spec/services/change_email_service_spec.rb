require 'rails_helper'

RSpec.describe ChangeEmailService do
  let(:user) { create(:user) }
  let(:new_email) { FFaker::Internet.email } 
  let(:valid_params) { { email: new_email, id: user.id } }
  let(:not_valid_params) { { email: 'test', id: user.id } }

  context 'when email valid' do
    let(:change_email) { described_class.new(valid_params, user) }
    it 'change password' do
      expect{change_email.save}.to change{user.email}.from(user.email).to(new_email)
    end
  end

  context 'when email not valid' do
    let(:change_email) { described_class.new(not_valid_params, user) }
    it 'not change password' do
      expect(change_email.save).to eq(nil)
    end
  end
end