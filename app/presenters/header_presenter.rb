class HeaderPresenter < ApplicationPresenter
  def categories
    Category.all
  end

  def cart_count
    subject ? subject.order_items.pluck(:quantity).sum : 0
  end
end
