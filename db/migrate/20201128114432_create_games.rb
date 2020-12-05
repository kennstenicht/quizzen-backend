class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :title
      t.boolean :active
      t.string :password_digest
      t.references :quiz, foreign_key: true
      t.references :quiz_master, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
