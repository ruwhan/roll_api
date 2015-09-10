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
      get :index, { user_id: @voter_id }, format: :json 
    end

    it "should returns two histories that voter have voted" do 
      poll_response = JSON.parse(response.body, symbolize_names: true)
      expect(poll_response[:histories].length).to eql 2
    end

    it { should respond_with 200 }
  end
end
