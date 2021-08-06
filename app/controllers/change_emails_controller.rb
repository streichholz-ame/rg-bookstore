class ChangeEmailsController < ApplicationController
  def update
    change_email = ChangeEmailService.new(email_params, current_user)
    if change_email.save
      flash[:success] = I18n.t('flash.change_email_success')
    else
      flash[:error] = I18n.t('flash.change_email_error')
    end
    redirect_to edit_address_path(current_user)
  end

  private

  def email_params
    params.permit(:email, :id)
  end
end
