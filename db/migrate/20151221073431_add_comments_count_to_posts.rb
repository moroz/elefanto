class AddCommentsCountToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :comments_count, :integer, default: 0, :null => false
    ids = Set.new
    Comment.all.each {|c| ids << c.post_id}
    ids.each do |post_id|
      Post.reset_counters(post_id, :comments)
    end
  end
end
