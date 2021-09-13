require 'rails_helper'

RSpec.describe CartPresenter do
  let(:presenter) { described_class.new(order) }
  let(:order_item) { order.order_items.first }
  let(:order_item1) { order.order_items.last }
  let(:delivery) { create(:delivery) }

  describe 'book' do
    let(:order) { create(:order, :with_item) }
    let(:book) { Book.find(order.order_items.first.book_id) }
    let(:field) { :name }
    it 'find book' do
      expect(presenter.find_book(order_item)).to eq(book)
    end

    it 'give book info' do
      expect(presenter.book_info(order_item, field)).to eq(book.name)
    end
  end

  describe 'price' do
    let(:order) { create(:order, :with_item) }
    let(:book) { Book.find(order.order_items.first.book_id) }
    let(:book1) { Book.find(order.order_items.last.book_id) }
    let(:quantity) { order_item.quantity }
    let(:quantity1) { order_item1.quantity }

    it 'subtotal price' do
      expect(presenter.subtotal_price(order_item)).to eq(book.price * quantity)
    end

    it 'subtotal_order_price' do
      expect(presenter.subtotal_order_price).to eq((book.price * quantity) + (book1.price * quantity1))
    end
  end

  describe 'coupon' do
    let(:coupon) { create(:coupon) }
    let(:book) { Book.find(order.order_items.first.book_id) }
    let(:book1) { Book.find(order.order_items.last.book_id) }
    let(:quantity) { order_item.quantity }
    let(:quantity1) { order_item1.quantity }
    let(:total_price) { (book.price * quantity) + (book1.price * quantity1) }
    let(:coupon_price) { (total_price * coupon.discount / 100).round(2) }

    describe 'with coupon' do
      let(:order) { create(:order, :with_item, coupon_id: coupon.id) }
      it 'total order_price' do
        expect(presenter.total_order_price).to eq(total_price - coupon_price)
      end
    end

    describe 'without coupon' do
      let(:order) { create(:order, :with_item) }
      it 'price without coupon' do
        expect(presenter.total_order_price).to eq(total_price)
      end
    end

    describe 'delivery' do
      describe 'without coupon' do
        let(:order) { create(:order, :with_item, delivery_id: delivery.id) }
        it 'return delivery type' do
          expect(presenter.delivery_type).to eq(delivery)
        end

        it 'return price without coupon' do
          expect(presenter.subtotal_price_with_delivery).to eq(total_price + delivery.price)
        end
      end
      describe 'with coupon' do
        let(:order) { create(:order, :with_item, delivery_id: delivery.id, coupon_id: coupon.id) }
        it 'return price with coupon' do
          expect(presenter.total_price_with_delivery).to eq(total_price + delivery.price - coupon_price)
        end
      end
    end
    describe 'delivery_type'
    describe 'subtotal_price_with_delivery'
    describe 'total_price_with_delivery'
  end
end
