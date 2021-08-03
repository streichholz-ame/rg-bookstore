class SettingsController < ApplicationController
  before_action :authenticate_user!
  def index
    @address_presenter = AddressPresenter.new
  end
end
