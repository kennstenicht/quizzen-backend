class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games, id: :uuid do |t|
      t.boolean :active
      t.string :password_digest
      t.string :title

      t.references :quiz, foreign_key: true, type: :uuid
      t.references :quiz_master, foreign_key: { to_table: :users }, type: :uuid

      t.timestamps
    end
  end
end
