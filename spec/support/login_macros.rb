module LoginMacros
  def set_user_session(user)
    session[:user_id] = user.id
  end

  def sign_in(user)
    visit root_path
    click_link t(:login)

    within 'form' do
      fill_in t(:name), with: user.name
      fill_in t(:password), with: user.password

      click_button t(:login)
    end
  end
end