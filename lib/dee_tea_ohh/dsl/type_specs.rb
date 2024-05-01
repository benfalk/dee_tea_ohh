# frozen_string_literal: true

# = Type Specifications
#
# These helpers allow for a more ergonomic
# resolution of types
#
module DeeTeaOhh::DSL::TypeSpecs
  def Enum(*values) # rubocop:disable Naming/MethodName
    DeeTeaOhh::DSL::TypeResolver.resolve(values.to_set)
  end

  def Object(**attributes) # rubocop:disable Naming/MethodName
    attrs = attributes.map do |field_name, type_spec|
      DeeTeaOhh::Attribute.new(
        field_name:,
        type: DeeTeaOhh::DSL::TypeResolver.resolve(type_spec),
        is_required: true
      )
    end
    list = DeeTeaOhh::Attribute::List.new(attrs)
    DeeTeaOhh::Type::Object.new(list)
  end

  def Nullable(type_spec) # rubocop:disable Naming/MethodName
    type = DeeTeaOhh::DSL::TypeResolver.resolve(type_spec)
    DeeTeaOhh::Type::Nullable.new(type)
  end
end
