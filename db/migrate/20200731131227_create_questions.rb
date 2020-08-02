class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.string :label
      t.string :source
      t.datetime :date
      t.references :owner, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end