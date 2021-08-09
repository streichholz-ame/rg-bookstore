class ChangeEmailService
  attr_reader :current_user, :email_form

  def initialize(email_params, current_user)
    @current_user = current_user
    @email_form = EmailForm.new(email_params)
  end

  def save
    update_email if email_form.valid?
  end

  private

  def update_email
    current_user.update(email_form.attributes)
  end
end
