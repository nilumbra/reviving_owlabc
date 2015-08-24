class Profile < ActiveRecord::Base
  has_attached_file :avatar, :styles => { :thumb => "200x150#"}, :default_url => "/images/profile/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  belongs_to :user
end
