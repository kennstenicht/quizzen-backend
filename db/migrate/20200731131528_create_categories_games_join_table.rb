class CreateCategoriesGamesJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :categories, :games do |t|
      t.references :category, foreign_key: true
      t.references :game, foreign_key: true
    end
  end
end
