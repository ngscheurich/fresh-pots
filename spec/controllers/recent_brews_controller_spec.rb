require "rails_helper"

describe RecentBrewsController do
  login_user

  describe "GET #index" do
    it "assigns @recent_brews" do
      brew = create(:brew)
      get :index, params: { format: :json }
      expect(assigns(:recent_brews)).to eq([brew])
    end


    it "renders the index template" do
      get :index, params: { format: :json }
      expect(response).to render_template("index")
    end
  end
end
