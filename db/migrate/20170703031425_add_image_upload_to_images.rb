class AddImageUploadToImages < ActiveRecord::Migration[5.0]
  def up
    add_attachment :images, :image_upload
  end

  def down
    remove_attachment :imgaes, :image_upload
  end
end
