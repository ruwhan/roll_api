class PollSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_at, :updated_at

  has_one :user, serializer: UserViewModelSerializer
  has_many :choices, serializer: ChoiceViewModelSerializer

  embed :objects
end
