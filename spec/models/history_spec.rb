require 'rails_helper'

RSpec.describe History, type: :model do
  before { @history = FactoryGirl.build(:history) }
  subject { @history }

  it { should respond_to(:user_id) }
  it { should respond_to(:poll_id) }
  it { should respond_to(:choice_id) }

  it { should belong_to(:user) }
  it { should belong_to(:poll) }
  it { should have_one(:choice) }
end
