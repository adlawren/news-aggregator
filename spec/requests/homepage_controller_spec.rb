require 'rails_helper'

RSpec.describe HomepageController, type: :request do
  context "basic required" do
    context "creds present" do
      it "returns ok" do
        get "/", headers: { "Authorization" => "Basic YWRtaW46cGFzc3dvcmQ=" }

        expect(response).to be_ok
      end
    end

    context "creds missing" do
      it "returns unauthorized" do
        get "/"

        expect(response).to be_unauthorized
      end
    end
  end

  context "basic auth not required" do
    before do
      allow(ENV).to receive(:[]).with("ADMIN_USERNAME").and_return("")
      allow(ENV).to receive(:[]).with("ADMIN_PASSWORD").and_return("")
    end

    context "creds missing" do
      it "returns ok" do
        get "/"

        expect(response).to be_ok
      end
    end
  end
end
