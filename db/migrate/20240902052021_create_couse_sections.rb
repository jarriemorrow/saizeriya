class CreateCouseSections < ActiveRecord::Migration[7.0]
  def change
    create_table :couse_sections do |t|
      t.string :name

      t.timestamps
    end
  end
end
