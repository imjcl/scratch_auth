class User
  include Mongoid::Document
  before_create :encrypt_password
  before_update :needs_password?
  attr_accessor :password

  field :email, type: String
  field :password_hash, type: String
  field :password_salt, type: String

  validates_confirmation_of :password
  def encrypt_password
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  end

  def self.authenticate(email, password)
    user = User.where(email: email).first
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def needs_password?
    if password.nil?
      puts 'The password is currently empty...'
    else
      encrypt_password
    end 
  end
end