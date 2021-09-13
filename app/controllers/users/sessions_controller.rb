module Users
  class SessionsController < Devise::SessionsController
    def after_sign_in_path_for(_resource)
      request.params[:commit] == 'Log In with Password' ? checkout_index_path : root_path
    end
  end
end
