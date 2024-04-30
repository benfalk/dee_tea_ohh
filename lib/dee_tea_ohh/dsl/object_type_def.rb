# frozen_string_literal: true

# = Object Definition Tag
#
# This serves as a tag for produced
# transformation object definitions.
#
module DeeTeaOhh::DSL::ObjectTypeDef
  # @private
  module ClassMethods
    # @return [DeeTeaOhh::Type::Object]
    def dto_type = @dto_type

    def inherited(klass)
      super
      klass.extend(ClassMethods)
      klass.instance_variable_set(
        :@dto_type,
        dto_type
      )
    end

    # @return [Class<Data>]
    def extend_with(&)
      list = DeeTeaOhh::Attribute::ListBuilder.new(
        dto_type.attributes.to_a
      )
      builder = DeeTeaOhh::DSL::DataBuilder.new(list)
      builder.instance_exec(&)
      builder.build
    end
  end
  private_constant :ClassMethods

  def self.included(klass) = klass.extend(ClassMethods)
end
