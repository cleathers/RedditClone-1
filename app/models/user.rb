class User < ActiveRecord::Base
  before_validation :ensure_token
  validates :username, :presence => true, :uniqueness => true
  validates :password_digest, :presence => true
  validates :token, presence: true



  def initialize

  end

  def ensure_token
    self.token ||= SecureRandom.urlsafe_base64(16)
  end

end
