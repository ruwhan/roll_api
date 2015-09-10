class HistorySerializer < ActiveModel::Serializer
  attributes :id

  has_one :user, serializer: UserViewModelSerializer
  has_one :poll, serializer: PollViewModelSerializer
  has_one :choice, serializer: ChoiceViewModelSerializer
end
