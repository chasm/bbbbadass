class SiteController < ApplicationController
  before_filter :authorize, :except => [ :uuids ]
  
  # GET /
  def index
    @user = current_user
    gon.rabl :template => "app/views/users/show.json.rabl", :as => "current_user"
    
    gon.rabl
  end
  
  # GET /uuids
  # GET /uuids/:count
  def uuids
    render :json => (get_uuids( if params[:count] then params[:count].to_i else 1 end ))
  end
end