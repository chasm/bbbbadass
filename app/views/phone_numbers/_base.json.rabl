attributes :id, :area_code, :line_number, :extension, :purpose
    
child @user do
  attributes :id, :name
end
