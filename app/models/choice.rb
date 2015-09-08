class Choice < ActiveRecord::Base
  belongs_to :poll
  validates :label, presence: true
end
