# frozen_string_literal: true

class VehicleListing < DeeTeaOhh.object \
  do
    # @!attribute [r] vin
    #   @return [String]
    attribute(:vin, :string)

    # @!attribute [r] make_slug
    #   @return [String]
    attribute(:make_slug, :string)

    # @!attribute [r] model_slug
    #   @return [String]
    attribute(:model_slug, :string)

    # @!attribute [r] dealership_id
    #   @return [Integer]
    attribute(:dealership_id, :integer)

    # @!attribute [r] price
    #   @return [Float]
    attribute(:price, :float, null: true)

    # @!attribute [r] price_history
    #   @return [Array<Float>]
    attribute(:price_history, [:float], null: true)
  end
end

RSpec.describe VehicleListing do
  # @!attribute subject [r]
  #   @return [VehicleListing]
  subject do
    described_class.new(
      vin: 'xxx',
      make_slug: 'ford',
      model_slug: 'f-150',
      dealership_id: 42,
      price: 4200.69,
      price_history: [4199.99, 4200.69]
    )
  end

  let(:expected_json_schema) do
    {
      type: 'object',
      additionalProperties: false,
      required: %i[
        vin make_slug model_slug
        dealership_id price price_history
      ],
      properties: {
        vin: { type: 'string' },
        make_slug: { type: 'string' },
        model_slug: { type: 'string' },
        dealership_id: { type: 'integer' },
        price: {
          oneOf: [
            { type: 'numeric' },
            { type: 'null' }
          ]
        },
        price_history: {
          oneOf: [
            { type: 'array', items: { type: 'numeric' } },
            { type: 'null' }
          ]
        }
      }
    }
  end

  it do
    expect(subject.vin).to eq('xxx')
    expect(subject.make_slug).to eq('ford')
    expect(subject.model_slug).to eq('f-150')
    expect(subject.dealership_id).to eq(42)
    expect(subject.price).to eq(4200.69)
    expect(subject.price_history).to eq([4199.99, 4200.69])

    expect(DeeTeaOhh::Schema.json(subject))
      .to eq(expected_json_schema)

    expect(DeeTeaOhh::Schema.json(VehicleListing))
      .to eq(expected_json_schema)
  end
end
