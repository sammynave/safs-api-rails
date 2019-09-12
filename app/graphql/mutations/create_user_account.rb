class Mutations::CreateUserAccount < Mutations::BaseMutation
  argument :username, String, required: true
  argument :phone, String, required: true
  argument :email, String, required: true
  argument :password, String, required: true

  field :user, Types::UserType, null: true
  field :errors, [String], null: true

  def self.authorized?(object, context)
    context[:current_user].is_a?(GuestUser)
  end

  def resolve(username:, phone:, email:, password:)
    # client should redirect to log in page after creation
    user = User.new(
      username: username,
      phone: phone,
      email: email,
      password: password
    )
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
