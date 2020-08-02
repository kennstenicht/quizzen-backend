class CreateCategoriesQuestionsJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :categories, :questions do |t|
      t.references :category, foreign_key: true
      t.references :question, foreign_key: true
    end
  end
end
