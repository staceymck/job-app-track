class FollowUp < ActiveRecord::Base
  validates :action, presence: true
  enum action_status: {incomplete: 0, complete: 1}

  belongs_to :job_app
end