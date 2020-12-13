class CreateCategoriesQuestionsJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_table :categories_questions, id: :uuid do |t|
      t.references :category, foreign_key: true, type: :uuid
      t.references :question, foreign_key: true, type: :uuid
    end
  end
end
