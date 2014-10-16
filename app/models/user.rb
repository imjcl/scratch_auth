class User
  include Mongoid::Document
  before_create :encrypt_password
  before_update :needs_password?
  attr_accessor :password, :old_password

  field :email, type: String
  field :password_hash, type: String
  field :password_salt, type: String

  validates_confirmation_of :password
  validates_presence_of :password, on: :create

  has_one :role

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
    unless password && old_password
      if User.authenticate(email, old_password)
        encrypt_password
      end
    end 
  end
end