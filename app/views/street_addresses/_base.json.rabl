attributes :id, :street_one, :street_two, :city, :state, :zip_code, :purpose
    
child @user do
  attributes :id, :name
end
