require 'rails_helper'

RSpec.describe CreditCardPresenter do
  let(:credit_card_presenter) { described_class.new(credit_card) }
  let(:credit_card) { create(:credit_card) }
  let!(:order) { create(:order, :with_item, credit_card_id: credit_card.id, user_id: user.id) }
  let(:user) { create(:user) }

  it '#fill_card_fields' do
    expect(credit_card_presenter.fill_card_fields(:number)).to eq(credit_card.number)
  end

  it '#mask cvv' do
    code_length = credit_card.cvv.size
    cvv_result = '*' * code_length
    expect(credit_card_presenter.mask(:cvv)).to eq(cvv_result)
  end
end
