require "rails_helper"

describe PotsController do
  login_user

  describe "GET #index" do
    it "assigns @pots" do
      pot = create(:pot)
      get :index
      expect(assigns(:pots)).to eq([pot])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    before(:each) do
      @pot = create(:pot)
    end

    it "assigns @pot" do
      get :show, params: { id: @pot.id }
      expect(assigns(:pot)).to eq(@pot)
    end

    it "renders the show template" do
      get :show, params: { id: @pot.id }
      expect(response).to render_template("show")
    end
  end

  describe "GET #new" do
    it "assigns @pot" do
      get :new
      expect(assigns(:pot)).to be_a_new(Pot)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "GET #edit" do
    before(:each) do
      @pot = create(:pot)
    end

    it "assigns @pot" do
      get :edit, params: { id: @pot.id }
      expect(assigns(:pot)).to eq(@pot)
    end

    it "renders the edit template" do
      get :edit, params: { id: @pot.id }
      expect(response).to render_template("edit")
    end
  end

  describe "POST #create" do
    context "with valid params" do
      before(:each) do
        @params = { pot: valid_params }
      end

      it "creates a new pot" do
        expect { post :create, params: @params }.to change { Pot.count }.by(1)
      end

      it "assigns @pot" do
        post :create, params: @params
        expect(assigns(:pot)).to eq(Pot.last)
      end

      it "redirects to the created pot" do
        post :create, params: @params
        expect(response).to redirect_to(Pot.last)
      end
    end

    context "with invalid params" do
      before(:each) do
        @params = { pot: invalid_params }
      end

      it "assigns @pot" do
        post :create, params: @params
        expect(assigns(:pot)).to be_a_new(Pot).with(invalid_params)
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
        @pot = create(:pot)
        @params = { pot: valid_params }.merge(id: @pot.id)
      end

      it "updates the pot" do
        patch :update, params: @params
        @pot.reload
        expect(@pot.name).to eq(valid_params[:name])
      end

      it "assigns @pot" do
        patch :update, params: @params
        expect(assigns(:pot)).to eq(@pot)
      end

      it "redirects to the updated pot" do
        patch :update, params: @params
        expect(response).to redirect_to(@pot)
      end
    end

    context "with invalid params" do
      before(:each) do
        @pot = create(:pot)
        @params = { pot: invalid_params }.merge(id: @pot.id)
      end

      it "assigns @pot" do
        patch :update, params: @params
        expect(assigns(:pot)).to eq(@pot)
      end

      it "renders the new template" do
        patch :update, params: @params
        expect(response).to render_template("edit")
      end
    end
  end

  private

  def valid_params
    { name: "Pot" }
  end

  def invalid_params
    { name: "" }
  end
end
