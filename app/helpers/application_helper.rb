module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @user ||= User.new
  end

	def check_for_like?(post_id)
  	@a = current_user.statuses.where(post_id: post_id).first
  	if @a.nil?
  		true
  	else
  		false
    end
  end

 def like_count?(post_id)
 	p = Post.find(post_id)
 	 ct = p.statuses.where(like: true)
 	 @count = ct.count
 end

 def check_for_friend?(cuser_id)
  usr = User.find(cuser_id)
  if current_user.friend.where(friend_id: usr.id).first || usr.friend.where(friend_id: current_user.id).first
    true
  else
    false
  end
 end

 def check_for_delete?(comment)
  m = comment.user
  if current_user.id == m.id
    true
  else
    false
  end
 end

end
