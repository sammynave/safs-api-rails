module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser
    field :create_hang, mutation: Mutations::CreateHang
  end
end
