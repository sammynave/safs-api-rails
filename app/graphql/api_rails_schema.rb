# frozen_string_literal: true

class ApiRailsSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  def self.unauthorized_object(error)
    raise GraphQL::ExecutionError, "Not authorized to access this #{error.type.graphql_name}"
  end

  def self.unauthorized_field(error)
    raise GraphQL::ExecutionError, "The field #{error.field.graphql_name} on an object of type #{error.type.graphql_name} was hidden due to permissions"
  end
end
