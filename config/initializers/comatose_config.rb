Comatose.configure do |config|

  config.admin_title          = 'Administration'
  config.admin_helpers        = []
  config.admin_sub_title      = 'Administration Pages'
  config.content_type         = 'utf-8'
  config.default_filter       = ''
  config.default_processor    = :erb
  config.default_tree_level   = 3
  config.disable_caching      = true
  config.hidden_meta_fields   = 'filter'
  config.allow_import_export  = true
  
  # custom options
  config.allow_more_link      = true
  config.allow_import_export  = false
  config.allow_clear_cache    = false
  config.allow_add_child      = true
  config.allow_delete         = true
  config.allow_reordering     = true
  config.disable_title_edit   = false
  
  #config.helpers << ApplicationHelper

  # Includes AuthenticationSystem in the ComatoseController
  #config.includes << Authlogic::ActsAsAuthentic

  # Calls :login_required as a before_filter
  #config.authorization = :require_user
     
  # Includes AuthenticationSystem in the ComatoseAdminController
  config.admin_includes << Authlogic::ActsAsAuthentic

  # Returns the author name (login, in this case) for the current user
  config.admin_get_author do
    current_user.login
  end

  # Calls :login_required as a before_filterc
  #config.admin_authorization = :login_required
  config.admin_authorization = :require_user
    
  #Returns different admin 'root paths'
  # config.admin_get_root_page do
  #   ComatosePage.find_by_path( '' )
  # end

end

require "#{RAILS_ROOT}/vendor/plugins/comatose_engine/engine_config/boot.rb"