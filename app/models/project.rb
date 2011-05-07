class Project < ActiveRecord::Base
  belongs_to :user
  has_many :tasks, :dependent => :destroy
  validates :name, :presence => true, :uniqueness => {:scope => :user_id, :case_sensitive => false}, :length => { :within => 1..20, :allow_blank => true }
  default_scope order ('name')
end
