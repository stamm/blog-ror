def get_user
  @user = FactoryGirl.build(:user)
  User.delete_all name: @user.name

  @user.save
  @user.should be_valid
  @user
end