class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.text :fields
      t.integer :madlib_id

      t.timestamps
    end
  end
end
