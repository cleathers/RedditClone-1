class User < ActiveRecord::Base
  after_initialize :ensure_token
  validates :username, :presence => true, :uniqueness => true
  validates :password_digest, :presence => true
  validates :password, presence: true, length: {minimum: 1}, on: :create
  validates :token, presence: true

  attr_reader :password

  has_many :subs, foreign_key: :mod_id


  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    user.is_password?(password) ? user : nil
  end

  def self.generate_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_token!
    self.token = self.class.generate_token
    self.save!
    self.token
  end

  def password=(plain_text)
    @password = plain_text
    self.password_digest = BCrypt::Password.create(plain_text)
  end

  def is_password?(plain_text)
    BCrypt::Password.new(self.password_digest).is_password?(plain_text)
  end

  private
  def ensure_token
    self.token ||= self.class.generate_token
  end

end
