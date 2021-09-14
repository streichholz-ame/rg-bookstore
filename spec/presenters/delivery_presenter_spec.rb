require 'rails_helper'

RSpec.describe DeliveryPresenter do
  let(:presenter) { described_class.new(delivery) }
  let(:delivery) { create(:delivery) }
  let(:duration_info) { I18n.t('checkout.delivery.delivery_time', min: delivery.days_min, max: delivery.days_max) }

  it '#delivery duration' do
    expect(presenter.delivery_duration).to eq(duration_info)
  end
end
