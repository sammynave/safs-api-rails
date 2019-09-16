# frozen_string_literal: true

if Rails.env.development?
  user_table_exists = lambda do
    User.first
  rescue StandardError
    false
                      else
                        true
  end

  if user_table_exists.call

    Rails.application.config.after_initialize do
      user = User.find_by(
        username: 'dummy',
        phone: '123',
        email: 'dummy@dummy.com'
      ) || User.create!(
        username: 'dummy',
        phone: '123',
        email: 'dummy@dummy.com',
        password: 'some_password'
      )

      jwt = JsonWebToken.encode(user_id: user.id)
      GraphiQL::Rails.config.headers['Authorization'] = ->(_context) { "bearer #{jwt}" }
    end
  end
end
