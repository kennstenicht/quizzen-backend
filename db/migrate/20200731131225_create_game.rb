class CreateGame < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :title
      t.references :owner, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
