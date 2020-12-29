class CreateGamesUsersJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_table :games_users, id: :uuid do |t|
      t.references :game, foreign_key: true, type: :uuid
      t.references :user, foreign_key: true, type: :uuid
    end
  end
end
