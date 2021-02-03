class CreateJobApps < ActiveRecord::Migration
  def change
    create_table :job_apps do |t|
      t.string :job_title 
      t.string :job_description 
      t.string :company_name 
      t.string :company_location
      t.string :contact_name
      t.string :contact_title
      t.string :contact_phone
      t.string :contact_email
      t.date :date_applied
      t.integer :app_status, default: 0, index: true #Interested as default
      t.integer :offer_decision, default: 0 #NA as default
      t.text :notes
      t.integer :user_id
    end
  end
end
