module Users
  class RegistrationsController < Devise::RegistrationsController
    def create
      super
      current_or_guest_user
    end

    protected

    def after_sign_up_path_for(_resource)
      request.params[:commit] == 'Continue to Checkout' ? checkout_index_path : root_path
    end
  end
end
