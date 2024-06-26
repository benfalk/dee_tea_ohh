# frozen_string_literal: true

RSpec.describe DeeTeaOhh::Type::Object do
  let(:instance) { described_class.new(attr_list) }

  context 'with an empty list' do
    let(:attr_list) { build(:attribute_list) }

    it do
      expect(instance.attributes).to eq(attr_list)
      expect(DeeTeaOhh::Schema.json(instance)).to eq(
        {
          type: 'object',
          additionalProperties: false,
          required: [],
          properties: {}
        }
      )
    end
  end

  context 'with snippet attribute list' do
    let(:attr_list) { build(:attribute_list, :snippet) }

    it do
      expect(instance.attributes).to eq(attr_list)
      expect(DeeTeaOhh::Schema.json(instance)).to eq(
        {
          type: 'object',
          additionalProperties: false,
          required: %i[id title summary categories],
          properties: {
            id: { type: 'integer' },
            title: { type: 'string' },
            summary: { type: 'string' },
            categories: {
              type: 'array',
              items: { type: 'string' }
            }
          }
        }
      )
    end
  end
end
