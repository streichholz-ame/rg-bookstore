class AccountsController < ApplicationController
  def update
    change_password = ChangePasswordService.new(current_user, params).call
    if change_password
      flash[:success] = I18n.t('flash.change_password_success')
    else
      flash[:error] = I18n.t('flash.change_password_error')
    end
    sign_in(current_account, bypass: true)
    redirect_to settings_path
  end

  def destroy
    if current_user&.destroy
      flash[:success] = I18n.t('flash.destroy_success')
    else
      flash[:error] = I18n.t('flash.destroy_error')
    end
    redirect_to root_path
  end
end
