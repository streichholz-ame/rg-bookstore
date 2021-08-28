module Users
  class SessionsController < Devise::RegistrationsController
    prepend_before_filter :require_no_authentication

  end
end
