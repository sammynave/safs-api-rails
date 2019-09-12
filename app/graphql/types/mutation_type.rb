module Types
  class MutationType < Types::BaseObject
    field :create_user_account, mutation: Mutations::CreateUserAccount
    field :create_hang, mutation: Mutations::CreateHang
  end
end
