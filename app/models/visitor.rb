class Visitor < ApplicationRecord
  attr_accessor :remember_token, :reset_token
  before_save   :downcase_email
  before_create :generate_access_token

  validates :first_name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }, allow_nil: true

  has_many :event_visitors
  has_many :events, through: :event_visitors

  # Returns the hash digest of the given string.
  def Visitor.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def Visitor.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = Visitor.new_token
    update_attribute(:remember_digest, Visitor.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = Visitor.new_token
    update_attribute(:reset_digest,  Visitor.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  private

    # Converts email to all lower-case.
  def downcase_email
    self.email = email.downcase
  end

  def generate_access_token
    begin
      self.access_token = Visitor.new_token
    end while self.class.exists?(access_token: access_token)
  end
end
