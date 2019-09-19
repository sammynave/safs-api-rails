# frozen_string_literal: true

class Mutations::CreateNewHangType < Mutations::BaseMutation
  argument :name, String, required: true

  field :hang_type, Types::HangTypeType, null: true
  field :errors, [String], null: true

  def self.authorized?(_object, context)
    context[:current_user].is_a?(User)
  end

  def resolve(name:)
    hang_type = HangType.new(name: name)
    if hang_type.save
      { hang_type: hang_type, errors: [] }
    else
      { hang: nil, errors: hang_type.errors.full_messages }
    end
  end
end
