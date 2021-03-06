module LoginMacros
  def set_user_session(user)
    session[:user_id] = user.id
  end

  def sign_in(user)
    visit login_path

    within 'form' do
      fill_in t(:name), with: user.name
      fill_in t(:password), with: user.password

      click_button t(:login)
    end
  end
end