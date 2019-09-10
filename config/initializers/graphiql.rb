if Rails.env.development?
  user_table_exists = -> do
    User.first
  rescue
    false
  else
    true
  end

  if user_table_exists.call

    Rails.application.config.after_initialize do
      # Rails.application.config.middleware.insert_before 0, Rack::Cors do
      user = User.find_by(
        username: "dummy",
        phone: "123",
        email: "dummy@dummy.com"
      ) || User.create!(
        username: "dummy",
        phone: "123",
        email: "dummy@dummy.com",
        password: "some_password"
      )

      jwt = JsonWebToken.encode(user_id: user.id)

      GraphiQL::Rails.config.headers["Authorization"] = -> (context) { "bearer #{jwt}" }
    end
  end
end
