require 'spec_helper'
include Warden::Test::Helpers

describe Api::UsersController, type: :request do
  let(:user){ create :user, email: "teste@teste.com", password: "password" }
  let(:other_user){ name: "teste2", email: "teste2@teste.com", password: "password" }
  describe "#show" do
    context "when making a get request to show" do
      before do
        login_as(user, :scope => :user)
      end
      it "should return the user" do
        subdomain_get "users/#{user._id}"
        parsed_response = JSON.parse(response.body, symbolize_names: true)
        expect(parsed_response[:user][:email]).to eq "#{user.email}"
        expect(parsed_response[:user][:name]).to eq "#{user.name}"
        expect(parsed_response[:user][:api_key]).to eq "#{user.api_key}"
      end
    end
    context "when making a get request to show another user" do
      before do
        login_as(user, :scope => :user)
      end
      it "should return the current user and not the searched user" do
        subdomain_get "users/#{other_user._id}"
        parsed_response = JSON.parse(response.body, symbolize_names: true)
        expect(parsed_response[:user][:email]).to eq "#{user.email}"
        expect(parsed_response[:user][:name]).to eq "#{user.name}"
        expect(parsed_response[:user][:api_key]).to eq "#{user.api_key}"
      end
    end
    context "when making a get request to show but not logged in" do
      xit "should return an error" do
        subdomain_get "users/#{user._id}"
        expect(response).to_not be_success
      end
    end
    context "when making a get request to show but passed a wrong id" do
      before do
        login_as user
      end
      it "should return an error" do
        subdomain_get "users/1"
        expect(response).to_not be_success
      end
    end
  end
end
