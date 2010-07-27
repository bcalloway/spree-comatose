# Put your extension routes here.

map.namespace :admin do |admin|
  admin.pages           "/comatose_admin",    :controller => "comatose_admin", :action => :index
  admin.comatose_admin  "/pages",             :controller => "comatose_admin", :action => :index
  admin.approve_page    "/pages/approve/:id", :controller => 'comatose_admin', :action => :approve
  admin.deny_page       "/pages/deny/:id",    :controller => 'comatose_admin', :action => :deny
  admin.connect         "/pages",             :controller => 'comatose_admin', :action => :index
end  
