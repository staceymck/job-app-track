class FollowUp < ActiveRecord::Base
  validates :action, :complete_by, presence: true
  enum action_status: {incomplete: 0, complete: 1}

  belongs_to :job_app
end