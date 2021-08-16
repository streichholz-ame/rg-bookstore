class ChangePasswordService
  attr_reader :current_user, :params

  def initialize(current_user, params)
    @current_user = current_user
    @params = params
  end

  def call
    change_password if passwords_valid
  end

  private

  def passwords_valid
    current_password == params[:old_password] && params[:new_password] == params[:confirm_password]
  end

  def change_password
    current_user.reset_password(params[:new_password], params[:confirm_password])
  end

  def current_password
    database_password = User.find_by(id: current_user.id).encrypted_password
    BCrypt::Password.new(database_password)
  end
end
