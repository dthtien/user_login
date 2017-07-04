class RenameBirthDayColumnToBirthday < ActiveRecord::Migration[5.0]
  def change
    rename_column :profiles, :birth_day, :birthday
  end
end
