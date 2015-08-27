class Permission < ActiveRecord::Base
  validates :action, :subject, :description, presence: true
  has_and_belongs_to_many :roles
end
