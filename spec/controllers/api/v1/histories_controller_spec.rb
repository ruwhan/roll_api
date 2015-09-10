require 'rails_helper'

RSpec.describe Api::V1::HistoriesController, type: :controller do
  describe "GET #index" do 
    before(:each) do 
      @poll_owner = FactoryGirl.create :user 
      @voter = FactoryGirl.create :user 
      @poll1 = FactoryGirl.create(:poll, user: @poll_owner)
      @poll2 = FactoryGirl.create(:poll, user: @poll_owner)

      @history1 = FactoryGirl.create(:history, user: @voter, poll: @poll1, choice: @poll1.choices[0])
      @history2 = FactoryGirl.create(:history, user: @voter, poll: @poll2, choice: @poll2.choices[1])

      request.headers["Authorization"] = @voter.auth_token
      get :users, { user_id: @voter.id }, format: :json 
    end

    it "should returns two histories that voter have voted" do 
      history_responses = JSON.parse(response.body, symbolize_names: true)
      expect(history_responses[:histories].length).to eql 2
    end

    it "should return history that user_id matches voter id" do 
      history_responses = JSON.parse(response.body, symbolize_names: true)
      single_history = history_responses[:histories][0]
      expect(single_history[:user][:id]).to eql @voter.id
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do 
    before(:each) do 
      @poll_owner = FactoryGirl.create :user 
      @voter = FactoryGirl.create :user 
      @poll = FactoryGirl.create(:poll, user: @poll_owner)

      request.headers["Authorization"] = @voter.auth_token
      post :create, { history: { user_id: @voter.id, poll_id: @poll.id, choice_id: @poll.choices[0].id } }, format: :json
    end

    it "should return created history" do 
      history_response = JSON.parse(response.body, symbolize_names: true)
      expect(history_response[:history][:id]).not_to eql nil
    end

    it "should return created history and has user as voter" do 
      history_response = JSON.parse(response.body, symbolize_names: true)
      expect(history_response[:history][:user][:id]).to eql @voter.id
    end

   it { should respond_with 201 }
  end
end
