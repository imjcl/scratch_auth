module PostsHelper
  def posted_on
    (@post.created_at).strftime('%A - %B %d, %Y')
  end
end