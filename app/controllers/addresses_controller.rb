class AddressesController < ApplicationController
  def edit
    authorize current_user, policy_class: AddressPolicy
    address_presenter
  end

  def create
    address_presenter
    update_address = Addresses::Edit.new(permitted_params, current_user).call
    if update_address
      flash[:success] = I18n.t('flash.change_address_success')
    else
      flash[:error] = I18n.t('flash.change_address_error')
    end

    redirect_to edit_address_path(current_user)
  end

  private

  def address_presenter
    @presenter = AddressPresenter.new(current_user)
  end

  def permitted_params
    params.require(:address_form).permit(:addressable_id, :addressable_type, :type, :first_name, :last_name, :address,
                                         :city, :zip, :country, :phone)
  end
end
