class StreetAddress
  include MongoMapper::EmbeddedDocument
  
  def self.address_types
    ['home', 'work', 'vacation', 'temporaray', 'mailing']
  end
  
  attr_accessible :_id, :street_one, :street_two, :city, :state, :zip_code, :purpose

  key :_id, String, :required => true
  key :street_one, String, :required => true
  key :street_two, String
  key :city, String, :required => true
  key :state, String, :required => true
  key :zip_code, String, :required => true
  key :purpose, String, :required => true, :in => self.address_types

end
