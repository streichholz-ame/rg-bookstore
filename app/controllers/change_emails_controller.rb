class ChangeEmailsController < ApplicationController
  def update
    change_email = ChangeEmailService.new(params_permitted, current_user)
    if change_email.update
      flash[:success] = I18n.t('flash.change_email_success')
    else
      flash[:error] = I18n.t('flash.change_email_error')
    end
    redirect_to settings_path
  end

  private

  def params_permitted
    params.permit(:email, :user_id)
  end
end
