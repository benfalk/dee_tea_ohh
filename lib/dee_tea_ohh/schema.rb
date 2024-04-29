# frozen_string_literal: true

module DeeTeaOhh
  # = Schema
  #
  # Responsible for producing different schema
  # formats which describe the data type provided
  # to it.
  #
  module Schema
    require_relative 'schema/json'

    module_function

    # @param raw_type [DeeTeaOhh::Type::Base]
    # @return [Hash]
    def json(raw_type)
      type = DeeTeaOhh::DSL::TypeResolver.resolve(raw_type)
      JSON.schema(type)
    end
  end
end
