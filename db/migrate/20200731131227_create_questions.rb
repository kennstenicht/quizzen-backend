class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions, id: :uuid do |t|
      t.datetime :date
      t.string :label
      t.string :source

      t.references :owner, foreign_key: { to_table: :users }, type: :uuid

      t.timestamps
    end
  end
end
