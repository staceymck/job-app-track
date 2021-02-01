class JobApp < ActiveRecord::Base
  validates :job_title, presence: true
  enum app_status: {interested: 0, applied: 1, interview: 2, offer: 3, no_offer: 4, withdrawn: 5}
  enum offer_decision: {na: 0, accepted: 1, declined: 2}

  belongs_to :user
  has_many :follow_ups
end