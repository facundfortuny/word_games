class CreateMadlibs < ActiveRecord::Migration
  def change
    create_table :madlibs do |t|
      t.text :text
      t.text :fields

      t.timestamps
    end
  end
end
