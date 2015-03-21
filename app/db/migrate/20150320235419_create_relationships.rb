class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.string :subject
      t.string :predicate
      t.string :object
      t.timestamps null: false
    end
  end
end
