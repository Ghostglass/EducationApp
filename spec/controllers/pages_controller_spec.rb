require 'rails_helper'

RSpec.describe "/", type: :request do
  describe "GET / " do
    it "responds with 200" do
      get "/"
      expect(response).to have_http_status(200)
    end
  end
end