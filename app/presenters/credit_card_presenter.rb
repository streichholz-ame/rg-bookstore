class CreditCardPresenter < ApplicationPresenter
  def new_card
    PaymentForm.new
  end

  def fill_card_fields(field)
    return if subject.nil?

    mask(field) if field == :cvv
    subject[field]
  end

  def mask(field)
    subject[field].gsub!(/[0-9]/, '*')
  end
end
