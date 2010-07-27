class AddSiteIdToComatosePages < ActiveRecord::Migration
  def self.up
    add_column :comatose_pages, :site_id, :integer
    add_column :comatose_page_versions, :site_id, :integer
  end

  def self.down
    remove_column :comatose_page_versions, :site_id
    remove_column :comatose_pages, :site_id
  end
end