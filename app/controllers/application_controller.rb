class ApplicationController < ActionController::Base
  # protect_from_forgery
  
  private
  
  def get_uuids(count)
    (0...count).to_a.map do
      SecureRandom.uuid
    end
  end
  helper_method :get_uuids

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize
    redirect_to login_url, alert: "Not authorized" if current_user.nil?
  end
  
  def get_ancestors_and_self
    Rails.application.routes.routes.to_a.select do |r|
      # Find the routes for this controller/action pair
      r.defaults[:action] == params[:action] and r.defaults[:controller] == params[:controller]
    end.map do |r|
      # Split them to arrays of path segments
      r.path.spec.to_s.chomp("(.:format)").split("/")
    end.inject do |m,r|
      # Select the array with the most segments
      m.length > r.length ? m : r
    end.select do |s| 
      # Select only those segments that end with _id
      s.ends_with?("_id")
    end.map do |s|
      # Remove the : from the front
      s[1..-1]
    end.select do |s|
      # Choose only those keys in the params hash
      params.keys.include?(s)
    end << "#{params[:controller].singularize}_id" # Add the current controller
  end
end
