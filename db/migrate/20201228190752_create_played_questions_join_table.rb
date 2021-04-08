class CreatePlayedQuestionsJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_table :played_questions, id: :uuid do |t|
      t.integer :position, index: true

      t.references :game, foreign_key: true, type: :uuid
      t.references :question, foreign_key: true, type: :uuid
      t.references :winner, foreign_key: { to_table: :users }, type: :uuid

      t.timestamps
    end
  end
end
