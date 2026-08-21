require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:experience) { create(:experience, :current) }

  describe 'associations' do
    it 'belongs to experience' do
      association = described_class.reflect_on_association(:experience)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'has many project_skills' do
      association = described_class.reflect_on_association(:project_skills)
      expect(association.macro).to eq(:has_many)
    end

    it 'has many skills through project_skills' do
      association = described_class.reflect_on_association(:skills)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:through]).to eq(:project_skills)
    end
  end

  describe 'validations' do
    it 'is valid with name, experience, and display_order' do
      project = build(:project, name: 'POS System', experience: experience, display_order: 1)
      expect(project).to be_valid
    end

    it 'is invalid without a name' do
      project = build(:project, name: nil, experience: experience)
      expect(project).not_to be_valid
      expect(project.errors[:name]).to include("can't be blank")
    end

    it 'is invalid without an experience' do
      project = build(:project, name: 'POS System', experience: nil)
      expect(project).not_to be_valid
    end

    it 'is invalid with non-integer display_order' do
      project = build(:project, name: 'POS', experience: experience, display_order: 1.5)
      expect(project).not_to be_valid
    end

    it 'is invalid with negative display_order' do
      project = build(:project, name: 'POS', experience: experience, display_order: -1)
      expect(project).not_to be_valid
    end

    it 'validates end_date is after start_date' do
      project = build(:project, name: 'POS', experience: experience, start_date: Date.today, end_date: Date.today - 1.day)
      expect(project).not_to be_valid
      expect(project.errors[:end_date]).to include('must be after start date')
    end
  end
end
