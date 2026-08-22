require 'rails_helper'

RSpec.describe Skill, type: :model do
  describe 'associations' do
    it 'has many experience_skills' do
      association = described_class.reflect_on_association(:experience_skills)
      expect(association.macro).to eq(:has_many)
    end

    it 'has many experiences through experience_skills' do
      association = described_class.reflect_on_association(:experiences)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:through]).to eq(:experience_skills)
    end

    it 'has many project_skills' do
      association = described_class.reflect_on_association(:project_skills)
      expect(association.macro).to eq(:has_many)
    end

    it 'has many projects through project_skills' do
      association = described_class.reflect_on_association(:projects)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:through]).to eq(:project_skills)
    end
  end

  describe 'validations' do
    it 'is valid with name, category, level, years and display_order' do
      skill = build(:skill, name: 'Ruby on Rails', category: 'Backend', level: 'Expert', years: 8, display_order: 1)
      expect(skill).to be_valid
    end

    it 'is invalid without a name' do
      skill = build(:skill, name: nil)
      expect(skill).not_to be_valid
      expect(skill.errors[:name]).to include("can't be blank")
    end

    it 'validates uniqueness of name' do
      create(:skill, name: 'Ruby on Rails')
      duplicate = build(:skill, name: 'Ruby on Rails')
      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:name]).to include('has already been taken')
    end

    it 'is invalid with non-integer display_order' do
      skill = build(:skill, name: 'Ruby', display_order: 1.5)
      expect(skill).not_to be_valid
    end

    it 'is invalid with negative display_order' do
      skill = build(:skill, name: 'Ruby', display_order: -1)
      expect(skill).not_to be_valid
    end

    it 'is invalid with non-integer years' do
      skill = build(:skill, name: 'Ruby', years: 1.5)
      expect(skill).not_to be_valid
    end

    it 'is invalid with negative years' do
      skill = build(:skill, name: 'Ruby', years: -1)
      expect(skill).not_to be_valid
    end
  end
end
