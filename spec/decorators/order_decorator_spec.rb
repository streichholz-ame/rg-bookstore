require 'rails_helper'

RSpec.describe OrderDecorator do
  let(:user) { create(:user) }
  let(:address) { create(:billing_address, addressable: user) }
  let(:delivery) { create(:delivery) }
  let(:credit_card) { create(:credit_card) }
  let!(:order) do
    create(:order, :with_item, :with_delivery, :with_credit_card, user_id: user.id, address_id: address.id)
  end
  let(:decorator) { described_class.new(order).decorate }

  describe '#order_status' do
    describe 'processing checkout' do
      it 'return status' do
        expect(decorator.order_status).to eq('Processing')
      end
    end

    describe 'complete' do
      let(:order) { create(:order, :with_item, user_id: user.id, status: 'complete') }
      it 'return status' do
        expect(decorator.order_status).to eq('In Progress')
      end
    end

    describe 'in delivery' do
      let(:order) { create(:order, :with_item, user_id: user.id, status: 'in_delivery') }
      it 'return status' do
        expect(decorator.order_status).to eq('In Delivery')
      end
    end

    describe 'delivered' do
      let(:order) { create(:order, :with_item, user_id: user.id, status: 'delivered') }
      it 'return status' do
        expect(decorator.order_status).to eq('Delivered')
      end
    end

    describe 'canceled' do
      let(:order) { create(:order, :with_item, user_id: user.id, status: 'canceled') }
      it 'return status' do
        expect(decorator.order_status).to eq('Canceled')
      end
    end
  end

  describe 'order_price' do
    let(:order_item) { order.order_items.first }
    let(:order_item1) { order.order_items.last }
    let(:book_price) { Book.find(order_item.book_id)[:price] }
    let(:book_price1) { Book.find(order_item1.book_id)[:price] }
    it 'return order_price' do
      expect(decorator.order_price).to eq(book_price * order_item.quantity + book_price1 * order_item1.quantity)
    end
  end
  describe 'address' do
    it 'return address' do
      expect(decorator.delivery_address).to eq(address)
    end
  end

  describe 'when shipping address dont exist' do
    let(:address_id) { address.id }
    it 'return no shipping address' do
      expect(decorator.shipping_address(address_id)).to eq(nil)
    end

    it 'return billing address' do
      expect(decorator.billing_address(address_id)).to eq(address)
    end
  end
  describe 'shipping address if exist' do
    let(:shipping_address) { create(:shipping_address, addressable: user) }
    let(:order_with_shipping_address) do
      create(:order, :with_item, user_id: user.id, address_id: [shipping_address.id, address.id])
    end

    it 'return no billing address' do
      expect(decorator.billing_address(address.id)).to eq(address)
    end

    it 'return shipping address' do
      expect(decorator.shipping_address(shipping_address.id)).to eq(shipping_address)
    end
  end
  describe 'receiver_name' do
    let(:full_name) do
      I18n.t('checkout.complete.receiver_name', first_name: address.first_name, last_name: address.last_name)
    end
    it 'return receiver full name' do
      expect(decorator.receiver_name).to eq(full_name)
    end
  end
  describe 'full_address' do
    let(:full_address) { I18n.t('checkout.complete.full_address', city: address.city, zip: address.zip) }

    it 'return receiver full address' do
      expect(decorator.full_address).to eq(full_address)
    end
  end
  describe 'phone' do
    let(:phone) { I18n.t('checkout.complete.phone', phone: address.phone) }
    it 'return user phone' do
      expect(decorator.phone).to eq(phone)
    end
  end
  describe 'card_number' do
    let(:card_number) { credit_card.number }
    let(:masked_number) { I18n.t('checkout.complete.masked_card_number', number: card_number.last(4)) }
    it 'return masked number' do
      expect(decorator.card_number).to eq(masked_number)
    end
  end

  describe 'cvv' do
    let(:masked_cvv) { '***' }
    it 'return masked cvv' do
      expect(decorator.cvv).to eq(masked_cvv)
    end
  end

  describe 'with coupon' do
    let(:order) { create(:order, :with_item, :with_coupon, :with_delivery, user_id: user.id) }
    let(:coupon) { decorator.order_price * order.coupon.discount / 100 }
    let(:price_with_coupon) { decorator.delivery_price - coupon }
    it 'total price' do 
      expect(decorator.total_price).to eq(price_with_coupon.round(2))
    end

    it 'coupon price' do
      expect(decorator.coupon_price).to eq(coupon.round(2))
    end
  end

  describe 'price_with_delivery' do
    let(:order_item) { order.order_items.first }
    let(:order_item1) { order.order_items.last }
    let(:book_price) { Book.find(order_item.book_id)[:price] }
    let(:book_price1) { Book.find(order_item1.book_id)[:price] }
    let(:order_price) { book_price * order_item.quantity + book_price1 * order_item1.quantity }
    it 'return full price' do
      expect(decorator.price_with_delivery).to eq(I18n.t('order.price', price: order_price + delivery.price))
    end
  end

  describe 'date complete' do
    let(:order) { create(:order, :with_item, user_id: user.id, status: 'delivered') }
    describe 'delivered order' do
      it 'return date' do
        expect(decorator.date_complete).to eq(order.updated_at.to_date)
      end
    end
    describe 'not delivered' do
      let(:order) { create(:order, :with_item, user_id: user.id, status: 'in_delivery') }
      it 'not return date' do
        expect(decorator.date_complete).not_to eq(order.updated_at.to_date)
      end
    end
  end
end
