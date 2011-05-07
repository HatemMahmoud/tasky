class User < ActiveRecord::Base
  has_many :tasks, :dependent => :destroy
  has_many :projects, :dependent => :destroy
  has_many :contexts, :dependent => :destroy
  
  def self.create_with_omniauth(auth)  
    create! do |user|  
      user.provider = auth["provider"]  
      user.uid = auth["uid"]  
      user.name = auth["user_info"]["name"]  
    end
  end
end