require "rails_helper"

describe BrewsController do
  login_user

  describe "GET #index" do
    it "assigns @brews" do
      brew = create(:brew)
      get :index
      expect(assigns(:brews)).to eq([brew])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    before(:each) do
      @brew = create(:brew)
    end

    it "assigns @brew" do
      get :show, params: { id: @brew.id }
      expect(assigns(:brew)).to eq(@brew)
    end

    it "renders the show template" do
      get :show, params: { id: @brew.id }
      expect(response).to render_template("show")
    end
  end

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

  describe "GET #edit" do
    before(:each) do
      @brew = create(:brew)
    end

    it "assigns @brew" do
      get :edit, params: { id: @brew.id }
      expect(assigns(:brew)).to eq(@brew)
    end

    it "renders the edit template" do
      get :edit, params: { id: @brew.id }
      expect(response).to render_template("edit")
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
        expect { post :create, params: @params }.to change { Brew.count }.by(1)
      end

      it "assigns @brew" do
        post :create, params: @params
        expect(assigns(:brew)).to eq(Brew.last)
      end

      it "redirects to the created brew" do
        post :create, params: @params
        expect(response).to redirect_to(Brew.last)
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

  describe "PATCH #update" do
    context "with valid params" do
      before(:each) do
        @brew = create(:brew)
        pot = create(:pot)
        @params = { brew: { pot_id: pot.id } }.merge(id: @brew.id)
      end

      it "updates the brew" do
        patch :update, params: @params
        @brew.reload
        expect(@brew.pot_id).to eq(@params[:brew][:pot_id])
      end

      it "assigns @brew" do
        patch :update, params: @params
        expect(assigns(:brew)).to eq(@brew)
      end

      it "redirects to the updated brew" do
        patch :update, params: @params
        expect(response).to redirect_to(@brew)
      end
    end

    context "with invalid params" do
      before(:each) do
        @brew = create(:brew)
        @params = { brew: { pot_id: nil } }.merge(id: @brew.id)
      end

      it "assigns @brews" do
        patch :update, params: @params
        expect(assigns(:brews)).to eq(@brews)
      end

      it "renders the new template" do
        patch :update, params: @params
        expect(response).to render_template("edit")
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
