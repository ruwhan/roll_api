require 'rails_helper'

RSpec.describe History, type: :model do
  before do  
    @poll_owner = FactoryGirl.create(:user)
    @voter = FactoryGirl.create(:user) 
    @poll = FactoryGirl.create(:poll, user: @poll_owner)
    @choice = @poll.choices[0]
    @history = FactoryGirl.create(:history, user: @voter, poll: @poll, choice: @choice) 
  end

  subject { @history }

  it { should respond_to(:user_id) }
  it { should respond_to(:poll_id) }
  it { should respond_to(:choice_id) }

  it { should belong_to(:user) }
  it { should belong_to(:poll) }
  it { should belong_to(:choice) }
  # it { should have_one(:choice) }

  describe ""
end
