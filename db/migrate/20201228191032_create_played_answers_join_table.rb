class CreatePlayedAnswersJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_table :played_answers, id: :uuid do |t|
      t.integer :position, index: true

      t.references :answer, foreign_key: true, type: :uuid
      t.references :played_question, foreign_key: true, type: :uuid
      t.references :user, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
