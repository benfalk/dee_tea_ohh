# frozen_string_literal: true

RSpec.describe DeeTeaOhh::Type::Array do
  let(:type) { DeeTeaOhh::Type::Float.new }
  let(:instance) { described_class.new(type) }

  it do
    expect(instance.type).to eq(type)
    expect(instance.json_schema).to eq(
      {
        type: 'array',
        items: { type: 'numeric' }
      }
    )
  end
end
