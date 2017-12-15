require "rails_helper"

describe Api::BrewsController do
  login_user

  describe "GET #recent" do
    it "assigns @recent_brews" do
      @brew = create(:brew)
      get :recent, params: { format: :json }
      expect(assigns[:recent_brews]).to eq([@brew])
    end

    it "doesn't return brews older than the configured max age" do
      Rails.configuration.fresh_pots["max_brew_hours"] = 5
      @brew = create(:brew)

      Timecop.freeze(Time.current - 6.hours) do get :recent, params: { format: :json }
        expect(assigns[:recent_brews]).not_to include(@brew)
      end
    end

    it "returns brews newer than the configured max age" do
      Rails.configuration.fresh_pots["max_brew_hours"] = 5
      @brew = create(:brew)

      Timecop.freeze(Time.current - 5.hours) do
        get :recent, params: { format: :json }
        expect(assigns[:recent_brews]).not_to include(@brew)
      end
    end

    it "renders the recent template" do
      get :recent, params: { format: :json }
      expect(response).to render_template("recent")
    end
  end

  describe "PATCH #exhaust" do
    before(:each) do
      @brew = create(:brew)
    end

    it "exhausts the brew" do
      patch :exhaust, params: { id: @brew.id }
      expect(@brew.reload.status).to eq("exhausted")
    end

    it "responds with no content" do
      patch :exhaust, params: { id: @brew.id }
      expect(response.status).to eq(204)
    end
  end
end
