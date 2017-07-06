class ChangeDatatpe < ActiveRecord::Migration[5.0]
  def change
    change_column :friendships, :status, 'integer USING CAST(status AS integer)'
  end
end
