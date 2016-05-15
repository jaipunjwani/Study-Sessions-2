class CreateSessionmembers < ActiveRecord::Migration
  def change
    create_table :sessionmembers do |t|
      t.references :studysession, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
