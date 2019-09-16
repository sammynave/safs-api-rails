# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_hang, mutation: Mutations::CreateHang
  end
end
