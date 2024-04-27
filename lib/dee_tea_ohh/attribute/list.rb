# frozen_string_literal: true

# = Attribute Collection
#
class DeeTeaOhh::Attribute::List
  class MissingAttribute < DeeTeaOhh::Error; end
  include Enumerable

  # @return [DeeTeaOhh::Attribute::List]
  def self.empty = @empty ||= new([])

  # @param attributes [Array<DeeTeaOhh::Attribute>]
  def initialize(attributes = [])
    @attributes = attributes.uniq(&:field_name).freeze

    # @type [Hash<Symbol, DeeTeaOhh::Attribute>]
    @lookup =
      @attributes
      .each_with_object({}) do |attr, lookup|
        lookup[attr.field_name] = attr
      end
      .freeze
    freeze
  end

  # @param key [Symbol]
  # @return [DeeTeaOhh::Attribute]
  def attr(key)
    @lookup.fetch(key) do |attr_key|
      raise MissingAttribute, <<~MSG.strip!
        Missing Attribute [#{attr_key}]
        Available Fields:
          #{@attributes.map(&:field_name).join("\n  ")}
      MSG
    end
  end
  alias [] attr

  def required = each.select(&:is_required)

  # @return [Hash<Symbol, DeeTeaOhh::Attribute>]
  def to_h = @lookup

  # Interface for Enumerable
  # @yieldparam [DeeTeaOhh::Attribute]
  def each(&)
    return enum_for(:each) unless block_given?

    @attributes.each(&)
  end
end
