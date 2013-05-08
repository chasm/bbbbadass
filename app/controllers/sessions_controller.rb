class SessionsController < ApplicationController
  # GET /login
  def new
    render :new, :layout => 'layouts/public'
  end
  
  # POST /login
  def create
    if params[:email]
      @user = User.find_by_email(params[:email])
    
      if params[:password].blank?
        UserMailer.reset_email(@user, request).deliver
        redirect_to login_url, notice: "Your password reset email has been sent!"
      else
        if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
      
          redirect_to root_url, :notice => "Welcome to the Bridge City Automotive website admin interface."
        else
          flash.now.alert = "Invalid email or password"
          render "new"
        end
      end
    end
  end

  # DELETE /logout
  def destroy
    session[:user_id] = nil
    
    redirect_to login_url, :notice => "You have successfully logged out. Please do come back soon."
  end
  
  # GET /reset/:code
  def reset
    @user = User.find_by_code(params[:code])
    
    if @user
      render :reset, :layout => 'layouts/public'
    else
      redirect_to :login, :alert => "You're reset code has expired. Please create a new one."
    end
  end
  
  # PUT /reset/:code
  def reset_password
    @user = User.find_by_code(params[:code])
    
    if @user
      if @user.update_attributes(params[:user])
        @user.code = nil
        @user.expires_at = nil
        @user.save
      
        session[:user_id] = @user.id
      
        redirect_to root_url, :notice => "You're password has been reset."
      else
        render :text => @user.name
      end
    else
      redirect_to :login, :alert => "You're reset code has expired. Please create a new one."
    end
  end
  
end