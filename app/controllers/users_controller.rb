class UsersController < ApplicationController

  def show
   @user = User.find(params[:id])
  end

  def index
    @users = User.all.page(params[:page]).per(5)
    @f= []
    @sfr  = []
    @cfr  = []
    @mt = []
    @users.each do |user|
     if current_user.id == user.id

     else
        friend = Friend.where(:user_id => current_user.id, :friend_id => user.id).first
        usr = Friend.where(:user_id => user.id, :friend_id => current_user.id).first
        if friend.nil? && usr.nil?
           fr_t = user.friend_request.where(:friend_id => current_user.id).first
           if !fr_t.nil?
              @mt.push(fr_t.user)
           else
              fr_request = current_user.friend_request.where(:friend_id => user.id).first
              if fr_request.nil?
              @sfr.push(user)
              else
              @cfr.push(user)
              end

           end

        else
          if !friend.nil?
          @f.push(user)

          else

          @f.push(user)

          end
        end
     end
    end
  end

  def all_friend_requests
    fr_req = FriendRequest.all.where(:friend_id => current_user.id)
    @frs = []
    fr_req.each do |fr|
     @frs.push(fr.user)
    end
    @frs = Kaminari.paginate_array(@frs).page(params[:page]).per(5)
  end

  def all_friends
    @fm = []
    @users = User.all
    @users.each do |user|
      if current_user.id == user.id

      else
       friend = current_user.friend.where( :friend_id => user.id).first
       usr = Friend.where(:user_id => user.id, :friend_id => current_user.id).first
       if !friend.nil?
       @fm.push(user)
       end
       if !usr.nil?
       @fm.push(user)
       end
      end
    end
    @fm = Kaminari.paginate_array(@fm).page(params[:page]).per(5)

  end

  def confirm
   fr_confirm = Friend.new(user_id:  current_user.id, friend_id: params[:id])
   if fr_confirm.save
      fr_req_s = FriendRequest.where(:user_id => params[:id], :friend_id => current_user.id).first
      if !fr_req_s.nil?
          fr_req_s.destroy
          redirect_to(root_url)
      end
   else
    flash[:notice] = "You confirmed it, Already. "
    redirect_to(root_url)
   end
  end

  def reject
   @user = User.find(params[:id])
   fr_req_s = FriendRequest.where(:user_id => params[:id], :friend_id => current_user.id).first
   if !fr_req_s.nil?
      fr_req_s.destroy
      redirect_to(root_url)
   else
      fr_req_ss = FriendRequest.where(:user_id => current_user.id, :friend_id => params[:id]).first
      fr_req_ss.destroy
      redirect_to(root_url)
    end
  end


  def send_friend_request
    @user = User.find(params[:id])
    fr_req = FriendRequest.new(user_id: current_user.id, friend_id: params[:id])
     if fr_req.save
        redirect_to(users_path)
     end
  end

  def cancel_friend_request
    fr_req_s = FriendRequest.where(:user_id => current_user.id, friend_id: params[:id]).first
    if fr_req_s.destroy
      flash[:notice] = "You have canceled friend request!!!"
      redirect_to(users_path)
    end
  end


end
