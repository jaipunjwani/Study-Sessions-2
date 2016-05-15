class CreateStudysessions < ActiveRecord::Migration
  def change
    create_table :studysessions do |t|
      t.string :subject
      t.string :location
      t.string :description

      t.timestamps null: false
    end
  end
end
