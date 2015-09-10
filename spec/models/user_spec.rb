require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = FactoryGirl.build(:user) }
  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:auth_token) }

  it { should be_valid }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_confirmation_of(:password) }
  it { should validate_uniqueness_of(:auth_token) }

  it { should have_many(:polls) }
  it { should have_many(:polls_through_history) }

  describe "#generate_authentication_token!" do 
    it "generates_authentication_token" do 
      Devise.stub(:friendly_token).and_return("auniquetoken123")
      @user.generate_authentication_token!
      expect(@user.auth_token).to eql "auniquetoken123"
    end

    it "generates another token when one already has been taken" do 
      existing_user = FactoryGirl.create(:user, auth_token: "auniquetoken123")
      @user.generate_authentication_token!
      expect(@user.auth_token).not_to eql existing_user.auth_token 
    end
  end

  describe "#polls association" do 
    before(:each) do 
      @user.save
      3.times { FactoryGirl.create(:poll, user: @user ) }
    end

    it "destroys the associated polls on self destruct" do 
      polls = @user.polls
      @user.destroy 

      polls.each do |poll|
        expect(Poll.find(poll)).to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
