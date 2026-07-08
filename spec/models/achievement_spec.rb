require 'rails_helper'

RSpec.describe Achievement, type: :model do
  let(:experience) { Experience.create!(company: 'Otto', position: 'Dev', start_date: Date.today, current: true) }

  describe 'associations' do
    it 'belongs to experience' do
      association = described_class.reflect_on_association(:experience)
      expect(association.macro).to eq(:belongs_to)
    end
  end

  describe 'validations' do
    it 'is valid with title and experience' do
      achievement = Achievement.new(title: 'Optimized POS', experience: experience, impact: '40%')
      expect(achievement).to be_valid
    end

    it 'is invalid without a title' do
      achievement = Achievement.new(title: nil, experience: experience)
      expect(achievement).not_to be_valid
      expect(achievement.errors[:title]).to include("can't be blank")
    end

    it 'is invalid without an experience' do
      achievement = Achievement.new(title: 'Optimized POS', experience: nil)
      expect(achievement).not_to be_valid
    end
  end
end
