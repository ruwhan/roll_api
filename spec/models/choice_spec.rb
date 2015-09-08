require 'rails_helper'

RSpec.describe Choice, type: :model do
  before do 
    @user = FactoryGirl.create(:user)
    @poll = FactoryGirl.create(:poll, user: @user) 
    @choice = FactoryGirl.create(:choice)
  end

  subject { @poll }

  it { should validate_presence_of(:label) }
  it { should belong_to(:poll) }
end
