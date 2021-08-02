class AddressController < ApplicationController
  def new
    @address_presenter = AddressPresenter.new(current_user: current_user)
  end
end
