# frozen_string_literal: true

# = Attribute
#
class DeeTeaOhh::Attribute
  # @return [Symbol]
  attr_reader :field_name

  # @return [DeeTeaOhh::Type::Base]
  attr_reader :type

  # @return [Boolean]
  attr_reader :is_required

  # @param field_name [Symbol]
  # @param type [DeeTeaOhh::Type::Base]
  def initialize(
    field_name:,
    type:,
    is_required: true
  )
    @field_name = field_name
    @type = type
    @is_required = is_required
    freeze
  end
end
