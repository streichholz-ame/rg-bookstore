class CreditCardPresenter < ApplicationPresenter
  attr_reader :credit_card

  def initialize(credit_card)
    @credit_card = credit_card
  end

  def new_card
    PaymentForm.new
  end

  def fill_card_fields(field)
    return if credit_card.nil?

    mask(field) if field == :cvv
    credit_card[field]
  end

  def mask(field)
    credit_card[field].gsub!(/[0-9]/, '*')
  end
end
