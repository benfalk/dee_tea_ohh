# frozen_string_literal: true

RSpec.describe DeeTeaOhh::Type::Nullable do
  let(:type) { DeeTeaOhh::Type::Float.new }
  let(:instance) { described_class.new(type) }

  it do
    expect(instance.type).to eq(type)
    expect(DeeTeaOhh::Schema.json(instance)).to eq(
      {
        oneOf: [
          { type: 'numeric' },
          { type: 'null' }
        ]
      }
    )
  end
end
