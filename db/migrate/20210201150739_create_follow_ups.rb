class CreateFollowUps < ActiveRecord::Migration
  def change
    create_table :follow_ups do |t|
      t.string :action
      t.datetime :complete_by
      t.integer :action_status, default: 0, index: true #Incomplete as default
      t.integer :job_app_id
    end
  end
end
