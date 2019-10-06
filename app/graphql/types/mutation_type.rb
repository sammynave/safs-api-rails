# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_hang, mutation: Mutations::CreateHang
    field :create_new_hang_type, mutation: Mutations::CreateNewHangType
    field :subscribe_to_hang_type, mutation: Mutations::SubscribeToHangType
    field :unsubscribe_from_hang_type, mutation: Mutations::UnsubscribeFromHangType
  end
end
