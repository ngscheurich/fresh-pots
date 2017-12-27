require "rails_helper"

describe BrewsController do
  login_user

  describe "GET #new" do
    it "assigns @brew" do
      get :new
      expect(assigns(:brew)).to be_a_new(Brew)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    context "with valid params" do
      before(:each) do
        allow(controller)
          .to receive(:current_user)
          .and_return(create(:user))

        @params = { brew: valid_params }
      end

      it "creates a new brew" do
        expect {
          post :create, params: @params
        }.to change { Brew.count }.by(1)
      end

      it "assigns @brew" do
        post :create, params: @params
        expect(assigns(:brew)).to eq(Brew.last)
      end

      it "redirects to the dashboard" do
        post :create, params: @params
        expect(response).to redirect_to(root_url)
      end
    end

    context "with invalid params" do
      before(:each) do
        @params = { brew: invalid_params }
      end

      it "assigns @brew" do
        post :create, params: @params
        expect(assigns(:brew)).to be_a_new(Brew).with(invalid_params)
      end

      it "renders the new template" do
        post :create, params: @params
        expect(response).to render_template("new")
      end
    end
  end

  private

  def valid_params
    pot = create(:pot)
    variety = create(:variety)
    { pot_id: pot.id, variety_id: variety.id }
  end

  def invalid_params
    { pot_id: nil }
  end
end
