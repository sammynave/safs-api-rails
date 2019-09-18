# frozen_string_literal: true

class Mutations::SubscribeToHangType < Mutations::BaseMutation
  argument :hang_type_id, String, required: true

  field :hang_subscription, Types::HangSubscriptionType, null: true
  field :hang_type, Types::HangTypeType, null: true
  field :errors, [String], null: true

  def self.authorized?(_object, context)
    context[:current_user].is_a?(User)
  end

  def resolve(hang_type_id:)
    hang_type = HangType.find(hang_type_id)
    user = context[:current_user]
    hang_subscription = HangSubscription.new(
      user: user,
      hang_type: hang_type
    )

    if hang_subscription.save
      {
        hang_subscription: hang_subscription,
        hang_type: HangType.includes(hang_subscriptions: [:user]).find(hang_type_id),
        errors: []
      }
    else
      {
        hang: nil,
        hang_type: nil,
        errors: hang_subscription.errors.full_messages
      }
    end
  end
end
