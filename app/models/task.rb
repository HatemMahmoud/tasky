class Task < ActiveRecord::Base
  belongs_to :user
  validates :name, :presence => true, :uniqueness => {:scope => :due_at, :case_sensitive => false}, :length => { :within => 3..250, :allow_blank => true }
  
  scope :done, where(:done => true).order('due_at, name')
  scope :due, where(:done => false).order('due_at, name')
  scope :overdue,  lambda { due.where("due_at < ?", Date.today.midnight) }
  scope :today,    lambda { due.where(:due_at => Date.today.midnight...Date.tomorrow.midnight) }
  scope :tomorrow, lambda { due.where(:due_at => Date.tomorrow.midnight...(Date.tomorrow.midnight + 1.day)) }
  scope :later,    lambda { due.where("due_at > ?", Date.tomorrow.midnight + 1.day) }
  scope :someday,  lambda { due.where(:due_at => nil) }
end
