class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :player_id
      t.integer :puzzle_id
      t.string :guessed_letters
      t.string :status

      t.timestamps
    end
  end
end
