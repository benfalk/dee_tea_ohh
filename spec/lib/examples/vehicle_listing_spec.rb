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

  it do
    expect(subject.vin).to eq('xxx')
    expect(subject.make_slug).to eq('ford')
    expect(subject.model_slug).to eq('f-150')
    expect(subject.dealership_id).to eq(42)
    expect(subject.price).to eq(4200.69)
    expect(subject.price_history).to eq([4199.99, 4200.69])
  end
end
