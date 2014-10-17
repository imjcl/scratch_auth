module PostsHelper
  def posted_on post
    (post.created_at).strftime('%B %d, %Y')
  end

  def in_path? str
    /#{str}/.match request.env['PATH_INFO']
  end
end