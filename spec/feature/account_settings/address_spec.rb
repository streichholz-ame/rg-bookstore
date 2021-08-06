require 'rails_helper'

RSpec.describe 'Address Settings Page', type: :feature do
  let(:user) { create(:user) }

  context 'shipping address' do
    scenario 'create new address'

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
