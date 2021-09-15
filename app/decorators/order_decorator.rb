class OrderDecorator < ApplicationDecorator
  delegate_all
  def order_status
    case order.status
    when 6 then 'Processing'
    when 7 then 'In Delivery'
    when 8 then 'Delivered'
    when 9 then 'Canceled'
    else 'Processing Checkout'
    end
  end

  def order_price(order)
    order.order_items.sum { |item| Book.find(item.book_id)[:price] * item.quantity }
  end

  def address
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
    "#{delivery_address.first_name} #{delivery_address.last_name}"
  end

  def full_address
    "#{delivery_address.city} #{delivery_address.zip}"
  end

  def phone
    "Phone #{delivery_address.phone}"
  end

  def card_number
    credit_card = CreditCard.find(subject.credit_card_id)
    credit_card_number = credit_card.number
    mask(credit_card_number)
  end

  def last_digits(number)
    number.to_s.length <= 4 ? number : number.to_s.slice(-4..-1)
  end

  def mask(number)
    "**** **** **** #{last_digits(number)}"
  end

  def cvv
    subject.credit_card.cvv.gsub!(/.(?=....)/, '*')
  end

  def delivery
    Delivery.find(subject.delivery_id)
  end

  def find_book(current_item)
    Book.find(current_item.book_id)
  end

  def subtotal_price(current_item)
    current_item.quantity * find_book(current_item).price
  end

  def price_with_delivery(order)
    order_price(order) + delivery.price
  end
end
