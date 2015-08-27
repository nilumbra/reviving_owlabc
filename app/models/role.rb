class Role < ActiveRecord::Base
  validates :name, presence: true
  has_and_belongs_to_many :admins
  has_and_belongs_to_many :permissions

  accepts_nested_attributes_for :permissions
  def permission_names
    self.permissions.map{ |p| p.action + ' ' + p.subject }.join("<br/>")
  end
end
