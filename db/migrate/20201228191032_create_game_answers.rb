class CreateGameAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :game_answers, id: :uuid do |t|
      t.references :answer, foreign_key: true, type: :uuid
      t.references :game_question, foreign_key: true, type: :uuid
      t.references :user, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
