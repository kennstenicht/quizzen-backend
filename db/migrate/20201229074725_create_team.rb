class CreateTeam < ActiveRecord::Migration[6.1]
  def change
    create_table :teams, id: :uuid do |t|
      t.string :name
      t.string :color

      t.references :game, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
