require 'rails_helper'

RSpec.describe ProjectSkill, type: :model do
  let(:experience) { create(:experience, :current) }
  let(:project) { create(:project, name: 'POS', experience: experience) }
  let(:skill) { create(:skill, name: 'Ruby') }

  describe 'associations' do
    it 'belongs to project' do
      association = described_class.reflect_on_association(:project)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'belongs to skill' do
      association = described_class.reflect_on_association(:skill)
      expect(association.macro).to eq(:belongs_to)
    end
  end

  describe 'validations' do
    it 'is valid with project and skill' do
      proj_skill = build(:project_skill, project: project, skill: skill)
      expect(proj_skill).to be_valid
    end

    it 'validates uniqueness of skill_id scoped to project_id' do
      create(:project_skill, project: project, skill: skill)
      duplicate = build(:project_skill, project: project, skill: skill)
      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:skill_id]).to include('has already been taken')
    end

    it 'raises a database-level error when trying to bypass validations to insert duplicate' do
      create(:project_skill, project: project, skill: skill)
      expect {
        build(:project_skill, project: project, skill: skill).save(validate: false)
      }.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end
end
