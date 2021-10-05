class OrderDecorator < ApplicationDecorator
  delegate_all
  def order_status
    case object.status.to_sym
    when :complete then t('order.sorting.processing')
    when :in_delivery then t('order.sorting.in_delivery')
    when :delivered then t('order.sorting.delivered')
    when :canceled then t('order.sorting.canceled')
    else t('order.sorting.waiting')
    end
  end

  def book_info(current_item, field)
    current_item.book[field]
  end

  def subtotal_price(current_item)
    current_item.quantity * current_item.book.price
  end

  def order_item_price(order_item)
    order_item.book[:price] * order_item.quantity
  end

  def order_price
    object.order_items.sum { |item| item.book[:price] * item.quantity }
  end

  def total_price
    delivery_price - coupon_price
  end

  def delivery_price
    order_price + object.delivery.price
  end

  def delivery_address
    delivery_address = object.address_id
    Address.find(delivery_address)
  end

  def shipping_address(address_id)
    return unless ShippingAddress.exists?(address_id)

    ShippingAddress.find(address_id)
  end

  def billing_address(address_id)
    BillingAddress.find(address_id)
  end

  def receiver_name
    I18n.t('checkout.complete.receiver_name', first_name: delivery_address.first_name,
                                              last_name: delivery_address.last_name)
  end

  def full_address
    I18n.t('checkout.complete.full_address', city: delivery_address.city, zip: delivery_address.zip)
  end

  def phone
    I18n.t('checkout.complete.phone', phone: delivery_address.phone)
  end

  def card_number
    mask(object.credit_card.number)
  end

  def cvv
    object.credit_card.cvv.gsub!(/[0-9]/, '*')
  end

  def price_with_delivery
    I18n.t('order.price', price: delivery_price)
  end

  def coupon_price
    object.coupon ? calculate_coupon_to_price : 0
  end

  private

  def mask(number)
    I18n.t('checkout.complete.masked_card_number', number: number.last(4))
  end

  def calculate_coupon_to_price
    ((object.coupon.discount * order_price) / 100).round(2)
  end
end
