class User < ActiveRecord::Base
  after_initialize :ensure_token
  validates :username, :presence => true, :uniqueness => true
  validates :password_digest, :presence => true
  validates :password, presence: true, length: {minimum: 1}, on: :create
  validates :token, presence: true

  attr_reader :password

  def password=(plain_text)
    @password = plain_text
    self.password_digest = BCrypt::Password.create(plain_text)
  end

  # def is_password?(plain_text)
  #   BCrypt::Password.new(self.password_digest).is_password?(plain_text)
  # end

  private
  def ensure_token
    self.token ||= SecureRandom.urlsafe_base64(16)
  end

end
