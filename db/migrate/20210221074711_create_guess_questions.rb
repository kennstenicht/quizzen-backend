class CreateGuessQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :guess_questions, id: :uuid do |t|
      t.float :answer
      t.string :unit
      t.datetime :date
      t.string :label
      t.string :source

      t.references :owner, foreign_key: { to_table: :users }, type: :uuid

      t.timestamps
    end
  end
end
