class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :title
      t.references :owner, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
