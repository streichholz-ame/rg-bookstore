class AddressPresenter
  attr_reader :params, :current_user, :billing_form, :shipping_form

  def billing
    billing_form || AddressForm.new
  end

  def shipping
    shipping_form || AddressForm.new
  end

  def countries_for_select
    ISO3166::Country.countries.sort_by(&:name)
  end
end
