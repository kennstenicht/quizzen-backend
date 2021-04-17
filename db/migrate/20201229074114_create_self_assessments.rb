class CreateSelfAssessments < ActiveRecord::Migration[6.1]
  def change
    create_table :self_assessments, id: :uuid do |t|
      t.string :assessment
      t.boolean :is_false_assessment, default: false

      t.references :played_question, foreign_key: true, type: :uuid
      t.references :user, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
