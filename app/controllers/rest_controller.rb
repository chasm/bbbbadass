class RestController < ApplicationController
  respond_to :json

  before_filter :authorize
  before_filter :pack_em_up
  
  # GET /automobiles
  def index
  end

  # GET /automobiles/:id
  def show
    head :not_found unless instance_variable_get("@#{@name}")
  end

  # PUT /automobiles/:id
  def update
    item = instance_variable_get("@#{@name}")
    symb = params[:controller].singularize.to_sym
    
    if item
      # This is an update request
      if item.update_attributes params[symb]
        head :no_content
      else
        render :errors, status: :unprocessable_entity 
      end
    else
      # This is a create request
      item = params[:controller].singularize.camelize.constantize.new params[symb]
      item.id = params[:id]
      
      if item.save
        render :show
      else
        render :errors, status: :unprocessable_entity 
      end
    end
  end

  # DELETE /automobiles/:id
  def destroy
    if item = instance_variable_get("@#{@name}")
      item.destroy
      head :no_content
    else
      head :not_found
    end
  end
  
  private
  
  def pack_em_up
    chain = get_ancestors_and_self
    
    while chain.length > 0 do
      item = chain.shift
      uuid = params[item] || params[:id]
      @name = item.chomp("_id")
      
      # First item, get the class, after that, get the association
      out = if out.nil?
        @name.camelize.constantize
      else
        out.__send__(@name.pluralize)
      end
      
      # If we have an id, find the object and set an instance variable
      # Else, if it's not an array (of associations), find all
      if uuid
        out = out.find(uuid)
        instance_variable_set("@#{@name}", out)
      else
        out = out.all if out.class != Array
        instance_variable_set("@#{@name.pluralize}", out)
      end
    end
  end
end
