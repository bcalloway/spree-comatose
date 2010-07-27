class ComatoseCmsHooks < Spree::ThemeSupport::HookListener

  insert_after :admin_tabs do
    %(<%= tab(:label => "CMS Pages", :route => :admin_comatose_admin) %>) 
  end

end
