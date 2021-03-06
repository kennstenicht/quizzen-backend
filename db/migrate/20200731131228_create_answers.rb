class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers, id: :uuid do |t|
      t.string :information
      t.string :label
      t.string :value

      t.references :question, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
