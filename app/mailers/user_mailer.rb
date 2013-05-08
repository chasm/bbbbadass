class UserMailer < ActionMailer::Base
  default from: "chas@munat.com"
  
  def reset_email(user, request)
    @user = user
    @user.code = SecureRandom.urlsafe_base64
    @user.expires_at = DateTime.now + 1
    @user.save
    @url = "#{request.protocol}#{request.host_with_port}/reset/#{@user.code}"
    mail :to => @user.email,
      :subject => "Reset your credentials for BBBBadass"
  end
end
