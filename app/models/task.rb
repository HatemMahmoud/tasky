class Task < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :name
  
  scope :overdue,  lambda { where("due_at < ? and done = ?", Date.today.midnight, false).order('due_at') }
  scope :today,    lambda { where(:due_at => Date.today.midnight...Date.tomorrow.midnight).order('due_at') }
  scope :tomorrow, lambda { where(:due_at => Date.tomorrow.midnight...(Date.tomorrow.midnight + 1.day)).order('due_at') }
  scope :later,    lambda { where("due_at > ?", Date.tomorrow.midnight + 1.day).order('due_at') }
  scope :someday,  lambda { where(:due_at => nil).order('name') }
end
