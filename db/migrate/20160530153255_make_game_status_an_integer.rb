class MakeGameStatusAnInteger < ActiveRecord::Migration[5.0]
  def change
    change_column :games, :status, 'integer USING CAST(status AS integer)'
  end
end
