require 'rails_helper'

RSpec.describe 'Address Settings Page', type: :feature do
  let(:user) { create(:user) }

  before :each do
    login_as(user)
    visit(edit_address_path(user))
  end

  context 'shipping address' do

    scenario 'create new address' do
    end

    scenario 'edit existing address'

    scenario 'when all fields are filled in'

    scenario 'when fields are empty'
  end

  context 'billing address' do
    scenario 'create new address'

    scenario 'edit existing address'

    scenario 'when all fields are filled in'

    scenario 'when fields are empty'
  end
end
