require 'rails_helper'

RSpec.describe OrderPresenter do
  let(:user) { create(:user) }
  let(:address) { create(:billing_address, addressable: user) }
  let(:delivery) { create(:delivery) }
  let(:credit_card) { create(:credit_card) }
  let!(:order) do
    create(:order, :with_item, user_id: user.id, address_id: address.id, credit_card_id: credit_card.id,
                               delivery_id: delivery.id)
  end
  let(:presenter) { described_class.new(order) }

  describe '#order_status' do
    let(:order_complete) { create(:order, :with_item, user_id: user.id, status: 'complete') }
    let(:order_in_delivery) { create(:order, :with_item, user_id: user.id, status: 'in_delivery') }
    let(:order_delivered) { create(:order, :with_item, user_id: user.id, status: 'delivered') }
    let(:order_canceled) { create(:order, :with_item, user_id: user.id, status: 'canceled') }

    it "return 'processing checkout'" do
      expect(presenter.order_status(order)).to eq('Processing Checkout')
    end

    it "return 'processing'" do
      expect(presenter.order_status(order_complete)).to eq('Processing')
    end

    it "return 'in delivery'" do
      expect(presenter.order_status(order_in_delivery)).to eq('In Delivery')
    end

    it "return 'delivered'" do
      expect(presenter.order_status(order_delivered)).to eq('Delivered')
    end

    it "return 'canceled'" do
      expect(presenter.order_status(order_canceled)).to eq('Canceled')
    end
  end

  describe 'order_item_price' do
    let(:order_item) { order.order_items.first }
    let(:book_price) { Book.find(order_item.book_id)[:price] }
    it 'return item price' do
      expect(presenter.order_item_price(order_item)).to eq(book_price * order_item.quantity)
    end
  end

  describe 'order_price' do
    let(:order_item) { order.order_items.first }
    let(:order_item1) { order.order_items.last }
    let(:book_price) { Book.find(order_item.book_id)[:price] }
    let(:book_price1) { Book.find(order_item1.book_id)[:price] }
    it 'return order_price' do
      expect(presenter.order_price(order)).to eq(book_price * order_item.quantity + book_price1 * order_item1.quantity)
    end
  end
  describe 'address' do
    it 'return address' do
      expect(presenter.address).to eq(address)
    end
  end

  describe 'when shipping address dont exist' do
    let(:address_id) { address.id }
    it 'return no shipping address' do
      expect(presenter.shipping_address(address_id)).to eq(nil)
    end

    it 'return billing address' do
      expect(presenter.billing_address(address_id)).to eq(address)
    end
  end
  describe 'shipping address if exist' do
    let(:shipping_address) { create(:shipping_address, addressable: user) }
    let(:order_with_shipping_address) do
      create(:order, :with_item, user_id: user.id, address_id: [shipping_address.id, address.id])
    end

    it 'return no billing address' do
      expect(presenter.billing_address(address.id)).to eq(address)
    end

    it 'return shipping address' do
      expect(presenter.shipping_address(shipping_address.id)).to eq(shipping_address)
    end
  end
  describe 'receiver_name' do
    let(:full_name) do
      I18n.t('checkout.complete.receiver_name', first_name: address.first_name, last_name: address.last_name)
    end
    it 'return receiver full name' do
      expect(presenter.receiver_name).to eq(full_name)
    end
  end
  describe 'full_address' do
    let(:full_address) { I18n.t('checkout.complete.full_address', city: address.city, zip: address.zip) }

    it 'return receiver full address' do
      expect(presenter.full_address).to eq(full_address)
    end
  end
  describe 'phone' do
    let(:phone) { I18n.t('checkout.complete.phone', phone: address.phone) }
    it 'return user phone' do
      expect(presenter.phone).to eq(phone)
    end
  end
  describe 'card_number' do
    let(:card_number) { credit_card.number }
    let(:masked_number) { I18n.t('checkout.complete.masked_card_number', number: card_number.last(4)) }
    it 'return masked number' do
      expect(presenter.card_number).to eq(masked_number)
    end
  end

  describe 'cvv' do
    let(:masked_cvv) { '***' }
    it 'return masked cvv' do
      expect(presenter.cvv).to eq(masked_cvv)
    end
  end

  describe 'delivery_type' do
    it 'return delivery type' do
      expect(presenter.delivery_type(order)).to eq(delivery)
    end
  end

  describe 'find_book' do
    let(:order_item) { order.order_items.first }
    let(:book) { Book.find(order_item.book_id) }
    it 'return book' do
      expect(presenter.find_book(order_item)).to eq(book)
    end
  end

  describe 'price_with_delivery' do
    let(:order_item) { order.order_items.first }
    let(:order_item1) { order.order_items.last }
    let(:book_price) { Book.find(order_item.book_id)[:price] }
    let(:book_price1) { Book.find(order_item1.book_id)[:price] }
    let(:order_price) { book_price * order_item.quantity + book_price1 * order_item1.quantity }
    it 'return full price' do
      expect(presenter.price_with_delivery(order)).to eq(order_price + delivery.price)
    end
  end
end
