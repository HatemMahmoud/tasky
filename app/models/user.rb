class User < ActiveRecord::Base
  has_many :tasks, :dependent => :destroy
  has_many :projects, :dependent => :destroy
  has_many :contexts, :dependent => :destroy
  
  validates_presence_of :identifier, :name, :email
  validates_uniqueness_of :identifier, :email, :case_sensitive => false
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :allow_blank => true
end
