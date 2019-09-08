class Mutations::CreateUser < Mutations::BaseMutation
  argument :username, String, required: true
  argument :phone, String, required: true
  argument :email, String, required: true

  field :user, Types::UserType, null: true
  field :errors, [String], null: true

  def resolve(username:, email:, phone:)
    user = User.new(username: username, email: email, phone: phone)
    if user.save
      # Successful creation, return the created object with no errors
      {
        user: user,
        errors: [],
      }
    else
      # Failed save, return the errors to the client
      {
        user: nil,
        errors: user.errors.full_messages
      }
    end
  end
end
