# frozen_string_literal: true

module DeeTeaOhh::Schema
  # @private
  module JSON
    module Constants
      NULL = { type: 'null' }.freeze
      INTEGER = { type: 'integer' }.freeze
      FLOAT = { type: 'numeric' }.freeze
      STRING = { type: 'string' }.freeze
      BOOLEAN = { type: 'boolean' }.freeze
    end
    private_constant :Constants

    refine DeeTeaOhh::Type::Object do
      # @!attribute [r] attributes
      #   @return [DeeTeaOhh::Attribute::List]

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
        attributes.required.map!(&:field_name).freeze
      end

      def properties
        attributes.to_h.transform_values do |attr|
          attr.type.schema
        end.freeze
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

    refine DeeTeaOhh::Type::Enum do
      def schema
        type.schema.merge(enum: values).freeze
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

    refine DeeTeaOhh::Type::Boolean do
      # @return [Hash]
      def schema = Constants::BOOLEAN
    end

    using self

    module_function

    # @param type [DeeTeaOhh::Type::Base]
    # @return [Hash]
    def schema(type) = type.schema
  end
  private_constant :JSON
end
