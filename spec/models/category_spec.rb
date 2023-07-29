# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validations' do
    let!(:category) { create(:category, name: 'Landscape') }

    it { is_expected.to validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }

    it 'validates name not to be blank' do
      category.name = ''
      expect(category).not_to be_valid
      expect(category.errors[:name]).to include("can't be blank")
      category.name = 'Paris France'

      expect(category).to be_valid
      expect(category.errors[:name]).to be_empty
    end

    it 'validates name uniqueness' do
      duplicate_category = build(:category, name: 'Landscape')
      expect(duplicate_category).not_to be_valid
      expect(duplicate_category.errors[:name]).not_to be_empty
      expect(duplicate_category.errors[:name]).to include('has already been taken')
    end
  end
end
