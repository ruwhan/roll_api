class Poll < ActiveRecord::Base
  belongs_to :user
  has_many :choices
  accepts_nested_attributes_for :choices
  
  validates :title, presence: true
  validates_each :choices do |record, attr, value| 
    record.errors.add attr, "choices required at least 2" if record.choices.length < 2
  end
end
