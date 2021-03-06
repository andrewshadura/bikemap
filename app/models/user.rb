class User < ActiveRecord::Base

  has_many :comments
  has_many :features
  has_and_belongs_to_many :liked_features, :join_table => :features_users_likes, :class_name => 'Feature'

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  attr_accessible :provider, :uid, :admin

  attr_accessor :login
  attr_accessible :login

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name:auth.extra.raw_info.name,
                         provider:auth.provider,
                         uid:auth.uid,
                         email:auth.info.email,
                         password:Devise.friendly_token[0,20]
                        )
    end
    user
  end

  def self.find_for_vkontakte_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid.to_s).first
    unless user
      user = User.create(name: "#{auth.info.first_name} #{auth.info.last_name}",
                         provider:auth.provider,
                         uid:auth.uid.to_s,
                         email:auth.extra.raw_info.domain + '@vk.com',
                         password:Devise.friendly_token[0,20]
                        )

    end
    user
  end

  def self.find_for_google_oauth2(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid.to_s).first
    unless user
      user = User.create(name: auth.info.name,
                         provider:auth.provider,
                         uid:auth.uid.to_s,
                         email:auth.info.email,
                         password:Devise.friendly_token[0,20]
                        )

    end
    user
  end

  def self.find_for_mailru_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid.to_s).first
    unless user
      user = User.create(name: auth.info.name,
                         provider:auth.provider,
                         uid:auth.uid.to_s,
                         email:auth.info.email,
                         password:Devise.friendly_token[0,20]
                        )

    end
    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(name) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

end
