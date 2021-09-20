require 'rails_helper'

describe OrderPolicy do
  subject { described_class }
  let(:logged_in_user) { create(:user) }
  let(:guest_user) { create(:user) }

  permissions :index?, :show?, :update?, :destroy? do
    before do
      logged_in_user.add_role :user
      guest_user.add_role :guest
    end
    it 'allows access if user logged in' do
      expect(subject).to permit(logged_in_user, Order.new)
    end

    it 'denies access if user guest' do
      expect(subject).not_to permit(guest_user, Order.new)
    end
  end
end
