# frozen_string_literal: true

# = Data Builder
class DeeTeaOhh::DSL::DataBuilder
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
    @builder = @builder.attribute(field_name, type:, null: false)
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

  private

  def Boolean # rubocop:disable Naming/MethodName
    DeeTeaOhh::Type::Boolean.new
  end

  def Object(**attributes) # rubocop:disable Naming/MethodName
    attrs = attributes.map do |field_name, type_spec|
      DeeTeaOhh::Attribute.new(
        field_name:,
        type: @resolver.resolve(type_spec),
        is_required: true
      )
    end
    list_builder = DeeTeaOhh::Attribute::ListBuilder.new(attrs)
    DeeTeaOhh::DSL::DataBuilder.new(list_builder).build
  end

  def Nullable(type_spec) # rubocop:disable Naming/MethodName
    type = @resolver.resolve(type_spec)
    DeeTeaOhh::Type::Nullable.new(type)
  end
end
