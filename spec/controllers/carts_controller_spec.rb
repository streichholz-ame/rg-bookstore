require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  describe 'when #index' do
    before do
      get :index
    end

    it { is_expected.to respond_with 200 }
  end
end
