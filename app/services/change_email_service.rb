class ChangeEmailService
  attr_reader :current_user, :email_form

  def initialize(params, current_user)
    @current_user = current_user
    @email_form = EmailForm.new(params)
  end

  def update
    update_email if email_form.valid?
  end

  private

  def update_email
    current_user.update(email_form.attributes.without(:user_id))
  end
end
