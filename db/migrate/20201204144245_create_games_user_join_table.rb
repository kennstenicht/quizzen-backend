class CreateGamesUserJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :games, :users do |t|
      t.references :game, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
