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
  # @param type [DeeTeaOhh::Type::Base]
  # @return [DeeTeaOhh::Attribute::ListBuilder]
  def attribute(field_name, type:, is_required: true)
    attr = DeeTeaOhh::Attribute.new(
      field_name:,
      type:,
      is_required:
    )
    self.class.new(@attributes + [attr])
  end

  # @return [DeeTeaOhh::Attribute::List]
  def build = DeeTeaOhh::Attribute::List.new(@attributes)
end
