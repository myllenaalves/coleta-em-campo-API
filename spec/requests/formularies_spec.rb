require 'rails_helper'

RSpec.describe "Formularies", type: :request do
  describe "GET /formularies" do
    it "works! (now write some real specs)" do
      get formularies_index_path
      expect(response).to have_http_status(200)
    end
  end
end
