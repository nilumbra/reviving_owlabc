class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
  validates :username,
  :presence => true,
  :uniqueness => {
    :case_sensitive => false
  } # etc.
  validates :username, :email, :presence => true
  has_and_belongs_to_many :roles
  has_many :permissions, through: :roles
  has_many :homeworks
  accepts_nested_attributes_for :roles

  def has_role?(role)
    self.roles.map{|role| role.name }.include?(role)
  end
  
  def role_names
    self.roles.map{ |role| role.title }.join(";")
  end

  attr_accessor :login
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions.to_hash).first
    end
  end
end
