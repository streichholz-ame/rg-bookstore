class DeliveryPresenter < ApplicationPresenter
  def delivery_duration
    I18n.t('checkout.delivery.delivery_time', min: subject.days_min, max: subject.days_max)
  end
end
