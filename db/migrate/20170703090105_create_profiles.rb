class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :address
      t.date :birth_day
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
