class CreatePlayedGuessQuestionAnswersJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_table :played_guess_question_answers, id: :uuid do |t|
      t.float :answer

      t.references :played_guess_question, foreign_key: true, type: :uuid
      t.references :user, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
