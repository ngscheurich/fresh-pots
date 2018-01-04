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
        expect { post :create, params: @params }.to(
          change { Brew.count }.by(1)
        )
      end

      it "assigns @brew" do
        post :create, params: @params
        expect(assigns(:brew)).to eq(Brew.last)
      end

      it "responds with OK status" do
        patch :create, params: @params
        expect(response.code).to eq("200")
      end

      it "assigns favorite pot to user without one" do
        user = create(:user, pot: nil)
        post :create, params: @params
        expect(user.pot_id).to eq(@params[:pot_id])
      end

      it "doesn’t assign favorite pot to user with one" do
        user = create(:user, pot: create(:pot))
        post :create, params: @params
        expect(user.pot_id).not_to eq(@params[:pot_id])
      end

      it "assigns favorite variety to user without one" do
        user = create(:user, variety: nil)
        post :create, params: @params
        expect(user.variety_id).to eq(@params[:variety_id])
      end

      it "doesn’t assign favorite variety to user with one" do
        user = create(:user, variety: create(:variety))
        post :create, params: @params
        expect(user.variety_id).not_to eq(@params[:variety_id])
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
