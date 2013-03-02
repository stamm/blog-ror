require 'spec_helper'

describe MarkitupController do

  describe "guest access" do
    it "needing login" do
      post :preview, data: '__test__'
      expect(response).to redirect_to(login_path)
    end
  end

  describe "admin access" do
    before :each do
      user = create :user
      set_user_session user
    end
    it 'render text' do
      text = Faker::Lorem.sentence
      html = "<p><strong>#{text}</strong></p>\n"
      post :preview, data: "__#{text}__"
      expect(assigns(:html)).to eq html
    end
  end
end