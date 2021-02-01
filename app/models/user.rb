class User < ActiveRecord::Base
  has_secure_password
  validates :username, presence: true, uniqueness: true
  
  has_many :job_apps
end