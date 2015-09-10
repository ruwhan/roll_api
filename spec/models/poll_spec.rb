require 'rails_helper'

RSpec.describe Poll, type: :model do
  before do 
    @user = FactoryGirl.create(:user)
    @poll = FactoryGirl.build(:poll, user: @user) 
  end

  subject { @poll }

  it { should respond_to(:title) }
  it { should respond_to(:description) }

  it { should validate_presence_of(:title) }

  it { should belong_to(:user) }
  it { should have_many(:choices) }
  it { should have_many(:users_through_history) }
  it { should accept_nested_attributes_for(:choices) }

  describe "#save" do 
    before(:each) do 
      @user = FactoryGirl.create(:user)
    end

    it "success" do 
      poll = FactoryGirl.build(:poll, user: @user)
      saved = poll.save
      expect(saved).to eql true
      expect(poll.choices[0].poll_id).to eql poll.id
    end

    it "fail when lack of choice" do 
      poll = FactoryGirl.build(:poll, :with_lack_of_choices, user: @user)
      saved = poll.save
      expect(saved).to eql false
    end

    it "fail when one or more choice is invalid" do 
      poll = FactoryGirl.build(:poll, :with_invalid_choices, user: @user)
      saved = poll.save
      expect(saved).to eql false
    end
  end
end
