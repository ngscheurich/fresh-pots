require "rails_helper"

describe Users::SessionsController do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = create(:user, email: "test@example.com")
    post :create, params: user_params("test@example.com")
  end

  describe "POST #create" do
    it "should set user_id cookie on login" do
      expect(cookies[:user_id]).to eq(@user.id)
    end
  end

  describe "DELETE #destroy" do
    it "should delete user_id cookie on sign out" do
      # FIXME: Why doesn't this pass?
      pending("Pending")
      delete :destroy
      expect(cookies[:user_id]).to be nil
    end
  end

  private

  def user_params(email)
    { user: { email: email, password: "password" } }
  end
end
