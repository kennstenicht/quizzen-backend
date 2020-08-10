class CreateCategoriesQuizzesJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :categories, :quizzes do |t|
      t.references :category, foreign_key: true
      t.references :quiz, foreign_key: true
    end
  end
end
