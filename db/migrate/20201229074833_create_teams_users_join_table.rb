class CreateTeamsUsersJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_table :teams_users, id: :uuid do |t|
      t.references :team, foreign_key: true, type: :uuid
      t.references :user, foreign_key: true, type: :uuid
    end
  end
end
