require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe 'when #index' do
    before do
      get :index
    end
  end
end
