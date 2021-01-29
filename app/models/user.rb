class User < ActiveRecord::Base
  has_secure_password
  validates :username, presence: true, uniqueness: true { message: "Username taken. Please select another or login."}

  has_many :job_apps
end