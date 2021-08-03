class AddressesController < ApplicationController
  def create
    AddressService.call
  end
end
