class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  belongs_to :context
  
  validates_presence_of :name
  
  scope :overdue,  lambda { where("due_at < ? and done = ?", Date.today.midnight, false).order('due_at') }
  scope :today,    lambda { where(:due_at => Date.today.midnight...Date.tomorrow.midnight).order('done, due_at') }
  scope :tomorrow, lambda { where(:due_at => Date.tomorrow.midnight...(Date.tomorrow.midnight + 1.day)).order('done, due_at') }
  scope :later,    lambda { where("due_at > ? and done = ?", Date.tomorrow.midnight + 1.day, false).order('due_at') }
  scope :someday,  lambda { where(:due_at => nil, :done => false).order('name') }
end
