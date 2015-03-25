class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels, {:id => false} do |t|
      t.string :id
      t.string :label
      t.text :description
      t.timestamps null: false
    end
    execute "ALTER TABLE levels ADD PRIMARY KEY (id);"
  end
end
