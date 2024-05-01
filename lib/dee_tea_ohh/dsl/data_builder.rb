# frozen_string_literal: true

# = Data Builder
class DeeTeaOhh::DSL::DataBuilder
  include DeeTeaOhh::DSL::TypeSpecs

  def initialize(builder = DeeTeaOhh::Attribute::ListBuilder.new)
    @builder = builder
    @resolver = DeeTeaOhh::DSL::TypeResolver
  end

  # @param field_name [Symbol]
  # @param type_spec [Object]
  # @param null [Boolean]
  # @return [void]
  def attribute(field_name, type_spec)
    type = @resolver.resolve(type_spec)
    @builder = @builder.attribute(field_name, type:)
    nil
  end

  # @return [Class]
  def build
    list = @builder.build
    dto_type = DeeTeaOhh::Type::Object.new(list)

    data = ::Data.define(*list.map(&:field_name))
    data.instance_variable_set(:@dto_type, dto_type)
    data.include(DeeTeaOhh::DSL::ObjectTypeDef)
    data
  end
end
