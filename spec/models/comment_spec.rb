# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject(:comment) { described_class.new }

  describe 'Associations' do
    it { should belong_to :location }
  end

  describe 'validations' do
    let!(:location) { create(:location) }

    it { is_expected.to validate_presence_of(:content) }

    it 'validates content not to be blank' do
      comment.content = ''
      expect(comment).not_to be_valid
      expect(comment.errors[:content]).to include("can't be blank")
      comment.content = 'This place was awesome'
      comment.location = location
      expect(comment).to be_valid
      expect(comment.errors[:content]).to be_empty
    end
  end
end
