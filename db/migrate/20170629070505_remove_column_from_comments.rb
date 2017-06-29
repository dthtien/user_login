class RemoveColumnFromComments < ActiveRecord::Migration[5.0]
  def change
    remove_reference :comments, :article, foreign_key: true
  end
end
