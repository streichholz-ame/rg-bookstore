class DeliveryPresenter < ApplicationPresenter
  def delivery_duration
    "#{subject.days_min} to #{subject.days_max} days"
  end
end
