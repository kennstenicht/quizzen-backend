class CreatePlayedGuessQuestionsJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_table :played_guess_questions, id: :uuid do |t|
      t.references :game, foreign_key: true, type: :uuid
      t.references :played_question, foreign_key: true, type: :uuid
      t.references :guess_question, foreign_key: true, type: :uuid
      t.references :winner, foreign_key: { to_table: :users }, type: :uuid

      t.timestamps
    end
  end
end
