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

    # @param type [DeeTeaOhh::Type::Base]
    # @return [Hash]
    def json(type) = JSON.schema(type)
  end
end
