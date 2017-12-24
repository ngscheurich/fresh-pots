require "rails_helper"

describe VarietiesController do
  login_user

  describe "GET #index" do
    it "assigns @varieties" do
      Variety.delete_all # TODO: What is up with this?
      variety = create(:variety)
      get :index
      expect(assigns(:varieties)).to eq([variety])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    before(:each) do
      @variety = create(:variety)
    end

    it "assigns @variety" do
      get :show, params: { id: @variety.id }
      expect(assigns(:variety)).to eq(@variety)
    end

    it "renders the show template" do
      get :show, params: { id: @variety.id }
      expect(response).to render_template("show")
    end
  end

  describe "GET #new" do
    it "assigns @variety" do
      get :new
      expect(assigns(:variety)).to be_a_new(Variety)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "GET #edit" do
    before(:each) do
      @variety = create(:variety)
    end

    it "assigns @variety" do
      get :edit, params: { id: @variety.id }
      expect(assigns(:variety)).to eq(@variety)
    end

    it "renders the edit template" do
      get :edit, params: { id: @variety.id }
      expect(response).to render_template("edit")
    end
  end

  describe "POST #create" do
    context "with valid params" do
      before(:each) do
        @params = { variety: valid_params }
      end

      it "creates a new variety" do
        expect { post :create, params: @params }.to change { Variety.count }.by(1)
      end

      it "assigns @variety" do
        post :create, params: @params
        expect(assigns(:variety)).to eq(Variety.last)
      end

      it "redirects to the created variety" do
        post :create, params: @params
        expect(response).to redirect_to(Variety.last)
      end
    end

    context "with invalid params" do
      before(:each) do
        @params = { variety: invalid_params }
      end

      it "assigns @variety" do
        post :create, params: @params
        expect(assigns(:variety)).to be_a_new(Variety).with(invalid_params)
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
        @variety = create(:variety)
        @params = { variety: valid_params }.merge(id: @variety.id)
      end

      it "updates the variety" do
        patch :update, params: @params
        @variety.reload
        expect(@variety.name).to eq(valid_params[:name])
      end

      it "assigns @variety" do
        patch :update, params: @params
        expect(assigns(:variety)).to eq(@variety)
      end

      it "redirects to the updated variety" do
        patch :update, params: @params
        expect(response).to redirect_to(@variety)
      end
    end

    context "with invalid params" do
      before(:each) do
        @variety = create(:variety)
        @params = { variety: invalid_params }.merge(id: @variety.id)
      end

      it "assigns @variety" do
        patch :update, params: @params
        expect(assigns(:variety)).to eq(@variety)
      end

      it "renders the new template" do
        patch :update, params: @params
        expect(response).to render_template("edit")
      end
    end
  end

  private

  def valid_params
    { name: "Variety" }
  end

  def invalid_params
    { name: "" }
  end
end
