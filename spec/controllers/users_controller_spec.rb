require "rails_helper"

describe UsersController do
  login_user

  describe "GET #show" do
    before(:each) do
      @user = create(:user)
    end

    it "assigns @user" do
      get :show, params: { id: @user.id }
      expect(assigns(:user)).to eq(@user)
    end

    it "renders the show template" do
      get :show, params: { id: @user.id }
      expect(response).to render_template("show")
    end
  end

  describe "GET #edit" do
    before(:each) do
      @user = create(:user)
      sign_in @user
    end

    context "when editing current_user" do
      it "assigns @user" do
        get :edit, params: { id: @user.id }
        expect(assigns(:user)).to eq(@user)
      end

      it "renders the edit template" do
        get :edit, params: { id: @user.id }
        expect(response).to render_template("edit")
      end
    end

    context "when editing another user" do
      it "redirects and set an error message" do
        interloper = create(:user)
        sign_in interloper

        get :edit, params: { id: @user.id }

        expect(response).to redirect_to user_path(interloper)
        expect(flash[:error]).to be_present
      end
    end
  end

  describe "PATCH #update" do
    before(:each) do
      @user = create(:user)
      sign_in @user
      @params = { user: valid_params }.merge(id: @user.id)
    end

    context "when updating the current user" do
      it "updates the user" do
        patch :update, params: @params
        @user.reload
        expect(@user.first_name).to eq(valid_params[:first_name])
      end

      it "assigns @user" do
        patch :update, params: @params
        expect(assigns(:user)).to eq(@user)
      end

      it "redirects to the updated user" do
        patch :update, params: @params
        expect(response).to redirect_to(@user)
      end
    end

    context "when editing another user" do
      it "redirects and set an error message" do
        interloper = create(:user)
        sign_in interloper

        get :edit, params: { id: @user.id }

        expect(response).to redirect_to user_path(interloper)
        expect(flash[:error]).to be_present
      end
    end
  end

  describe "GET #me" do
    it "redirects to the current user" do
      user = create(:user)
      sign_in user

      get :me

      expect(response).to redirect_to(user)
    end
  end

  private

  def valid_params
    { first_name: "John" }
  end
end
