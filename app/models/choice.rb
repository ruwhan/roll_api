class Choice < ActiveRecord::Base
  belongs_to :poll
  has_many :histories
  validates :label, presence: true
end
