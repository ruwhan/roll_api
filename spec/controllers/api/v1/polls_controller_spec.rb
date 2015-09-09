require 'rails_helper'

RSpec.describe Api::V1::PollsController, type: :controller do
  describe "GET #index" do
    before(:each) do 
      @user = FactoryGirl.create :user
      3.times { FactoryGirl.create(:poll, user: @user) }
      request.headers["Authorization"] = @user.auth_token
      get :index
    end

    it "should returns multiple users" do 
      polls_response = JSON.parse(response.body, symbolize_names: true)
      expect(polls_response[:polls].length).to eql 3
    end
  end

  describe "GET #show" do 
    before(:each) do 
      @user = FactoryGirl.create :user 
      @poll = FactoryGirl.create :poll, user: @user 
      request.headers["Authorization"] = @user.auth_token
      get :show, id: @poll.id, format: :json 
    end

    it "should returns an user" do 
      poll_response = JSON.parse(response.body, symbolize_names: true)
      expect(poll_response[:poll][:id]).to eql @poll.id 
    end

    it "should has same choices length as created" do 
      poll_response = JSON.parse(response.body, symbolize_names: true)
      expect(poll_response[:poll][:choices].length).to eql @poll.choices.length
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do 
    context "when is successfully created" do 
      before(:each) do 
        @user = FactoryGirl.create :user
        poll = FactoryGirl.attributes_for(:poll, user: @user)
        request.headers["Authorization"] = @user.auth_token
        post :create, {poll: poll}, format: :json 
      end

      it "should return created user" do 
        poll_response = JSON.parse(response.body, symbolize_names: true)
        expect(poll_response[:poll][:id]).not_to eql nil
      end

      it { should respond_with 201 }
    end

    context "when fail to create because lack of choices" do 
      before(:each) do 
        # notice I'm not including the email
        @user = FactoryGirl.create :user 
        @invalid_poll_choices = FactoryGirl.attributes_for :poll, :with_lack_of_choices
        request.headers["Authorization"] = @user.auth_token
        post :create, { poll: @invalid_poll_choices }, format: :json 
      end

      it "renders errors json" do 
        poll_response = JSON.parse(response.body, symbolize_names: true)
        expect(poll_response).to have_key(:errors)
      end

      it "renders errors json and why the poll could not be created" do 
        poll_response = JSON.parse(response.body, symbolize_names: true)
        expect(poll_response[:errors][:choices]).to include "choices required at least 2"
      end

      it { should respond_with 422 }
    end

    context "when fail to create because of invalid choices" do 
      before(:each) do 
        # notice I'm not including the email
        @user = FactoryGirl.create :user 
        @invalid_poll_choices = FactoryGirl.attributes_for :poll, :with_invalid_choices 
        request.headers["Authorization"] = @user.auth_token
        post :create, { poll: @invalid_poll_choices }, format: :json 
      end

      it "renders errors json" do 
        poll_response = JSON.parse(response.body, symbolize_names: true)
        expect(poll_response).to have_key(:errors)
      end

      it "renders the json errors on why the choice is invalid" do 
        poll_response = JSON.parse(response.body, symbolize_names: true)
        expect(poll_response[:errors][:"choices.label"]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end

  describe "DELETE #destroy" do 
    before(:each) do 
      @user = FactoryGirl.create :user 
      @poll = FactoryGirl.create :poll, user: @user 
      request.headers["Authorization"] = @user.auth_token
      delete :destroy, id: @poll.id, format: :json 
    end

    it { should respond_with 204 }
  end
end
