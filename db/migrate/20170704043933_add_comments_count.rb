class AddCommentsCount < ActiveRecord::Migration[5.0]
  def up
    add_column :posts, :comments_count, :integer, default: 0
    add_column :posts, :images_count, :integer, default: 0

    Post.reset_column_information
    Post.all.each do |p|
      Post.update_counters p.id, comments_count: p.comments.length, 
        images_count: p.images.length
    end
  end

  def down
    remove_column :posts, :comments_count, :integer, default: 0
    remove_column :posts, :images_count, :integer, default: 0
  end
end
