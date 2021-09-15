class OrderPresenter < ApplicationPresenter
  def order_status
    case subject.status
    when 'complete' then 'Processing'
    when 'in_delivery' then 'In Delivery'
    when 'delivered' then 'Delivered'
    when 'canceled' then 'Canceled'
    else 'Processing Checkout'
    end
  end

  def order_item_price(order_item)
    Book.find(order_item.book_id)[:price] * order_item.quantity
  end

  def order_price
    subject.order_items.sum { |item| Book.find(item.book_id)[:price] * item.quantity }
  end

  def delivery_address
    delivery_address = subject.address_id
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
    credit_card = CreditCard.find(subject.credit_card_id)
    credit_card_number = credit_card.number
    mask(credit_card_number)
  end

  def mask(number)
    I18n.t('checkout.complete.masked_card_number', number: number.last(4))
  end

  def cvv
    subject.credit_card.cvv.gsub!(/[0-9]/, '*')
  end

  def delivery_type
    Delivery.find(subject.delivery_id)
  end

  def find_book(current_item)
    Book.find(current_item.book_id)
  end

  def price_with_delivery
    order_price + delivery_type.price
  end
end
