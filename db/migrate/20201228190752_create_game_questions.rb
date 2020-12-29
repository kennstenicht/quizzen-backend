class CreateGameQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :game_questions, id: :uuid do |t|
      t.references :game, foreign_key: true, type: :uuid
      t.references :question, foreign_key: true, type: :uuid
      t.references :winner, foreign_key: { to_table: :users }, type: :uuid

      t.timestamps
    end
  end
end
