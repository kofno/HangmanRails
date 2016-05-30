class CreatePuzzles < ActiveRecord::Migration[5.0]
  def change
    create_table :puzzles do |t|
      t.text :phrase

      t.timestamps
    end
  end
end
