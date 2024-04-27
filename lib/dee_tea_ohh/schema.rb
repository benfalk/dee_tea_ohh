# frozen_string_literal: true

# = Schema
#
# Responsible for producing different schema
# formats which describe the data type provided
# to it.
#
module DeeTeaOhh::Schema
  # = JSON Schema
  #
  # Produces a json schema based on the information
  # from the type.  This schema can then be used to
  # validate a json payload to validate it before
  # decoding.
  #
  module JSON
    module Constants
      NULL = { type: 'null' }.freeze
      INTEGER = { type: 'integer' }.freeze
      FLOAT = { type: 'numeric' }.freeze
      STRING = { type: 'string' }.freeze
    end
    private_constant :Constants

    refine DeeTeaOhh::Type::Object do
      # @!attribute [r] attributes
      #   @return [Hash<Symbol, DeeTeaOhh::Attribute>]

      # @return [Hash]
      def schema
        {
          type: 'object',
          additionalProperties: false,
          required:,
          properties:
        }.freeze
      end

      private

      def required
        attributes
          .values
          .select(&:is_required)
          .map!(&:field_name)
          .freeze
      end

      def properties
        attributes
          .transform_values { |attr| attr.type.schema }
          .freeze
      end
    end

    refine DeeTeaOhh::Type::Nullable do
      # @!attribute [r] type
      #   @return [DeeTeaOhh::Type::Base]

      # @return [Hash]
      def schema
        {
          oneOf: [
            type.schema,
            Constants::NULL
          ].freeze
        }.freeze
      end
    end

    refine DeeTeaOhh::Type::Array do
      # @!attribute [r] type
      #   @return [DeeTeaOhh::Type::Base]

      def schema
        {
          type: 'array',
          items: type.schema
        }.freeze
      end
    end

    refine DeeTeaOhh::Type::String do
      # @return [Hash]
      def schema = Constants::STRING
    end

    refine DeeTeaOhh::Type::Integer do
      # @return [Hash]
      def schema = Constants::INTEGER
    end

    refine DeeTeaOhh::Type::Float do
      # @return [Hash]
      def schema = Constants::FLOAT
    end

    using self

    module_function

    # @param type [DeeTeaOhh::Type::Base]
    # @return [Hash]
    def schema_for(type) = type.schema
  end
end
