class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  
  # Protect these actions behind an admin login
  # before_filter :admin_required, :only => [:suspend, :unsuspend, :destroy, :purge]  
  before_filter :find_user, :only => [:home, :suspend, :unsuspend, :destroy, :purge, :edit, :update ]    
   
   
   #"home" is the only non-scaffolded controller method here.  Home is where a user can see
   # all his or her sequences, user observations, and eventually, posts. S/he can link to 
   # his/her profile (but can't update it! -- 
  def home
    @user
    @sequences = @user.sequences
    #@posts = @user.posts 
  end

  # render new.rhtml
  def new
    @user = User.new
  end 
  
  def show
   @user = User.find(params[:id]) 
 end
 
 def index
    @users = User.find(:all)    
 end   
 

  def edit
    @user 
  end 
   
  def update   #I stole this code from create, below; but neither it, nor my previous attempt, work.
    @user
    @user.register! if @user && @user.valid?
    success = @user && @user.valid?
  	if success && @user.errors.empty?#@user.update_attributes(params[:user])
     	flash[:notice] = 'User was successfully updated.'
     	redirect_back_or_default('/')
  	else
     	flash[:error]  = "We couldn't set up that account, sorry.  Please try again."
  		render :action => 'edit'     
  	end
  end
  
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    @user.register! if @user && @user.valid?
    success = @user && @user.valid?
    if success && @user.errors.empty?
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
      redirect_back_or_default('/')      
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end

  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      flash[:notice] = "Signup complete! Please sign in to continue."
      redirect_to '/login'
    when params[:activation_code].blank?
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      redirect_back_or_default('/')
    else 
      flash[:error]  = "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
      redirect_back_or_default('/')
    end
  end

  def suspend
    @user.suspend! 
    redirect_to users_path
  end

  def unsuspend
    @user.unsuspend! 
    redirect_to users_path
  end

  def destroy
    @user.delete!
    redirect_to users_path
  end

  def purge
    @user.destroy
    redirect_to users_path
  end
  
  # There's no page here to update or destroy a user.  If you add those, be
  # smart -- make sure you check that the visitor is authorized to do so, that they
  # supply their old password along with a new one to update it, etc.

protected
  def find_user
    @user = User.find(params[:id], :include => [:sequences, :user_observations, :posts, :comments])  
  end
end
