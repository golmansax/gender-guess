class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.integer :height
      t.integer :weight
      t.string :gender

      t.timestamps
    end
  end
end
