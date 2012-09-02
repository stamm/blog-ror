module SessionHelper

  def sign_in(user)
    self.current_user = user
  end
end