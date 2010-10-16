class Context < ActiveRecord::Base
  belongs_to :user
  has_many :tasks, :dependent => :nullify
  
  validates_presence_of :name
  validates_uniqueness_of :name
end
