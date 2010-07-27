# Uncomment this if you reference any of your controllers in activate
#require_dependency 'application'

class ComatoseCmsExtension < Spree::Extension
  version "1.0"
  description "Comatose CMS Spree Extension to allow the management of website content"
  url "http://github.com/bcalloway/spree-comatose"
  
  include Spree::BaseHelper
  
  def activate
    # Admin::ConfigurationsController.class_eval do
    # 
    #   before_filter :add_pages_tab
    # 
    #   def add_pages_tab
    #     #@extension_links << [ :comatose_cms, { :label => "Pages", :route => :admin_pages } ]
    #     @extension_links << {:link => admin_comatose_admin_path, :link_text =>"Pages", :description => "CMS Pages"}
    #   end
    # 
    # end
    
    Spree::BaseHelper.class_eval do
      def current_page
        @location = ComatosePage.find_by_path("#{request.request_uri}")
        if !@location.nil?
          return @location.id
        else
          return nil
        end
      end
    end
    
    Spree::BaseController.class_eval do
      
      before_filter :render_page_if_exists
      
      def render_page_if_exists
        if params[:path].to_s.match(/favicon/).nil? && params[:path].to_s.match(/javascript/).nil? && params[:path].to_s.match(/images/).nil?
          if request.request_uri == "/"
            @page = ComatosePage.find_by_path("/")
          else
            @page = ComatosePage.find_by_path("/#{params[:path].join('/')}") if params[:path]
            @exists = ComatosePage.full_path_eq("#{params[:path].join('/')}").first if params[:path]
            if params[:path] && @exists.nil?
              @page = ComatosePage.full_path_eq("404").first
            elsif params[:path] && @page.nil?
              @page = ComatosePage.find_previous_version("/#{params[:path].join('/')}")
              for @page in @page
                @page = @page
              end
            end
          end
          @page = ComatosePage.find_by_path(request.path) unless @page
          render :template => 'content/show' if @page
        end
      end
    end
  end
end