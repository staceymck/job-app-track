class User < ActiveRecord::Base
  has_secure_password
  validates :username, presence: true, uniqueness: true
  #validates :password, length: { minimum: 6 }
  
  has_many :job_apps, dependent: :destroy
end