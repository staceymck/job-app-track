class FollowUp < ActiveRecord::Base
  validates :action, :complete_by, presence: true
  validate :complete_by_date_cannot_be_in_past
  enum action_status: {incomplete: 0, complete: 1}

  belongs_to :job_app

  def complete_by_date_cannot_be_in_past
    errors.add(:complete_by, "can't be in the past") if
      !complete_by.blank? and complete_by < Date.today
  end
end