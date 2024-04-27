# frozen_string_literal: true

RSpec.describe DeeTeaOhh::Type::Object do
  let(:attributes) { {} }
  let(:instance) { described_class.new(attributes) }

  it do
    expect(instance.attributes).to eq(attributes)
    expect(instance.json_schema).to eq(
      {
        type: 'object',
        additionalProperties: false,
        required: [],
        properties: {}
      }
    )
  end

  context 'with a few attributes' do
    let(:attributes) do
      {
        foo: DeeTeaOhh::Attribute.new(
          field_name: :foo,
          type: DeeTeaOhh::Type::String.new,
          is_required: true
        ),
        bar: DeeTeaOhh::Attribute.new(
          field_name: :bar,
          type: DeeTeaOhh::Type::Integer.new,
          is_required: false
        )
      }
    end

    it do
      expect(instance.attributes).to eq(attributes)
      expect(instance.json_schema).to eq(
        {
          type: 'object',
          additionalProperties: false,
          required: [:foo],
          properties: {
            foo: { type: 'string' },
            bar: { type: 'integer' }
          }
        }
      )
    end
  end
end
