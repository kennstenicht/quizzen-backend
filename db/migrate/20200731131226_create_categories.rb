class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories, id: :uuid do |t|
      t.string :title
      t.references :owner, foreign_key: { to_table: :users }, type: :uuid

      t.timestamps
    end
  end
end
