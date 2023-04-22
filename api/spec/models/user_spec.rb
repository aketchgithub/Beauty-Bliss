require "rails_helper"

RSpec.describe User, type: :model do
    it "can be created successfully with valid data" do
        user = User.create(username: "test_user", password: "sup3r-secret")
        expect(user).to be_valid
    end

    it "has many orders" do
        expect(User.new).to respond_to(:orders)
    end

    describe "validations" do
        it { is_expected.to validate_presence_of(:username, :password) }
        it { is_expected.to validate_uniqueness_of(:username, :password) }
    end

    describe "authenticate" do
        it "returns the user if credentials match" do
            user = User.create(username: "test_user", password: "sup3r-secret")
            expect(user.authenticate("super-secret")).to eq(user)
        end

        it "returns false if credentials don't match" do
            user = User.create(username: "test_user", password: "sup3r-secret")
            expect(user.authenticate("nope")).to be(false)
        end
    end

end