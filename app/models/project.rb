class Project < ActiveRecord::Base
  belongs_to :user
  has_many :tasks, :dependent => :destroy
  
  validates_presence_of :name
  validates_uniqueness_of :name
end
