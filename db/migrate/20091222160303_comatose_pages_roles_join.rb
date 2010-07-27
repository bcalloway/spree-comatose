class ComatosePagesRolesJoin < ActiveRecord::Migration
  
  # Join table for roles and comatose_pages
  def self.up
    create_table  :comatose_pages_roles, :id => false do |t|
      t.integer   "comatose_page_id"
      t.integer   "role_id"
    end
  end
  
  def self.down
    drop_table :comatose_pages_roles
  end
  
end