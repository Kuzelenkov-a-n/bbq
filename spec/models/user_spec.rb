require "rails_helper"

RSpec.describe User, type: :model do
  let(:access_token) do
    double(
      :access_token,
      provider: "facebook",
      info: double(email: "example@example.com"),
      extra: double(raw_info: double(id: "123456789012345"))
    )
  end

  describe ".find_for_facebook_oauth" do
    context "when user is not find" do
      it "returns newly created user" do
        user = User.find_for_facebook_oauth(access_token)

        expect(user).to be_persisted
        expect(user.email).to eq "example@example.com"
      end
    end

    context "when user is found by email" do
      let!(:existing_user) { create(:user, email: "example@example.com") }
      let!(:other_user) { create(:user) }

      it "returns this user" do
        expect(User.find_for_facebook_oauth(access_token)).to eq existing_user
      end
    end

    context "when user is found by provider & url" do
      let!(:existing_user) { create(:user, provider: "facebook", url: "https://facebook.com/123456789012345") }
      let!(:other_user) { create(:user) }

      it "returns this user" do
        expect(User.find_for_facebook_oauth(access_token)).to eq existing_user
      end
    end
  end
end
