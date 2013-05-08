require 'bcrypt'

class User
  include MongoMapper::Document
  
  attr_accessible :_id, :name, :email, :code, :expires_at, :is_admin, :password, :password_confirmation
  
  attr_accessor :password

  key :_id, String, :required => true
  key :name, String, :required => true
  key :email, String, :required => true
  
  key :hash, String
  key :salt, String
  
  key :code, String
  key :expires_at, Time
  
  key :is_admin, Boolean, :default => false
  
  timestamps!
  
  many :phone_numbers
  many :street_addresses
  
  before_validation :downcase_email
  before_save :encrypt_password

  validates :email, :name, :presence => true
  
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :password, :password_confirmation, :confirmation => true
  
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.hash == BCrypt::Engine.hash_secret(password, user.salt)
      user
    else
      nil
    end
  end
  
  def authenticate(password)
    if self.hash == BCrypt::Engine.hash_secret(password, self.salt)
      self
    else
      nil
    end
  end
  
  private
  
  def downcase_email
    self.email.downcase!
  end
  
  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.hash = BCrypt::Engine.hash_secret(password, self.salt)
      self.password = nil
    end
  end

end
