class AccountsController < ApplicationController
  def update
    authorize Address
    change_password = ChangePasswordService.new(current_user, permitted_params).call
    if change_password
      flash[:success] = t('flash.change_password_success')
    else
      flash[:error] = t('flash.change_password_error')
    end
    bypass_sign_in(current_user)
    redirect_to edit_address_path(current_user)
  end

  def destroy
    authorize Address

    if current_user&.destroy
      flash[:success] = t('flash.destroy_success')
    else
      flash[:error] = t('flash.destroy_error')
    end
    redirect_to root_path
  end

  def permitted_params
    params.require(:user).permit(:old_password, :new_password, :confirm_password)
  end
end
