class CreateDirectors < ActiveRecord::Migration[7.0]
  def change
    create_table :directors do |t|
      t.string :name
      t.integer :years_active
      t.boolean :best_director

      t.timestamps
    end
  end
end
