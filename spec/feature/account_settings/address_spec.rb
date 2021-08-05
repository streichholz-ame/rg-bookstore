require 'rails_helper'

RSpec.describe 'Address Settings Page', type: :feature do
  let(:user) { create(:user) }
  
  context 'shipping address' do
    scenario 'when all fields are filled in' do

    end

    scenario ' when fields are empty'
  end

  context 'billing address' do
    scenario 'when all fields are filled in'

    scenario ' when fields are empty'
  end
end