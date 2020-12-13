class CreateCategoriesQuizzesJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_table :categories_quizzes, id: :uuid do |t|
      t.references :category, foreign_key: true, type: :uuid
      t.references :quiz, foreign_key: true, type: :uuid
    end
  end
end
