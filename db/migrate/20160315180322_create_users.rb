class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.integer :awkwardness
      t.string :fun_fact

      t.timestamps null: false
    end
  end
end
