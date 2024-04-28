# frozen_string_literal: true

# = Attribute Collection Builder
#
class DeeTeaOhh::Attribute::ListBuilder
  # @param attributes [Array<DeeTeaOhh::Attribute>]
  def initialize(attributes = [])
    @attributes = attributes
    freeze
  end

  # @param field_name [Symbol]
  # @param null [Boolean]
  # @return [DeeTeaOhh::Attribute::ListBuilder]
  def string(field_name, null: false)
    attribute(
      field_name,
      type: DeeTeaOhh::Type::String.new,
      null:
    )
  end

  # @param field_name [Symbol]
  # @param null [Boolean]
  # @return [DeeTeaOhh::Attribute::ListBuilder]
  def bool(field_name, null: false)
    attribute(
      field_name,
      type: DeeTeaOhh::Type::Boolean.new,
      null:
    )
  end

  # @param field_name [Symbol]
  # @param null [Boolean]
  # @return [DeeTeaOhh::Attribute::ListBuilder]
  def float(field_name, null: false)
    attribute(
      field_name,
      type: DeeTeaOhh::Type::Float.new,
      null:
    )
  end

  # @param field_name [Symbol]
  # @param null [Boolean]
  # @return [DeeTeaOhh::Attribute::ListBuilder]
  def integer(field_name, null: false)
    attribute(
      field_name,
      type: DeeTeaOhh::Type::Integer.new,
      null:
    )
  end

  # @param field_name [Symbol]
  # @param type [DeeTeaOhh::Type::Base]
  # @param null [Boolean]
  # @return [DeeTeaOhh::Attribute::ListBuilder]
  def array(field_name, type:, null: false)
    attribute(
      field_name,
      type: DeeTeaOhh::Type::Array.new(type),
      null:
    )
  end

  # @param field_name [Symbol]
  # @param type [DeeTeaOhh::Type::Base]
  # @param null [Boolean]
  # @return [DeeTeaOhh::Attribute::ListBuilder]
  def attribute(field_name, type:, null:)
    type = DeeTeaOhh::Type::Nullable.new(type) if null
    attr = DeeTeaOhh::Attribute.new(field_name:, type:)
    self.class.new(@attributes + [attr])
  end

  # @return [DeeTeaOhh::Attribute::List]
  def build = DeeTeaOhh::Attribute::List.new(@attributes)
end
