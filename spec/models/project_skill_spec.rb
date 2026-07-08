require 'rails_helper'

RSpec.describe ProjectSkill, type: :model do
  let(:experience) { Experience.create!(company: 'Otto', position: 'Dev', start_date: Date.today, current: true) }
  let(:project) { Project.create!(name: 'POS', experience: experience) }
  let(:skill) { Skill.create!(name: 'Ruby') }

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
      proj_skill = ProjectSkill.new(project: project, skill: skill)
      expect(proj_skill).to be_valid
    end

    it 'validates uniqueness of skill_id scoped to project_id' do
      ProjectSkill.create!(project: project, skill: skill)
      duplicate = ProjectSkill.new(project: project, skill: skill)
      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:skill_id]).to include('has already been taken')
    end

    it 'raises a database-level error when trying to bypass validations to insert duplicate' do
      ProjectSkill.create!(project: project, skill: skill)
      expect {
        ProjectSkill.new(project: project, skill: skill).save(validate: false)
      }.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end
end
