module Admin::ComatoseAdminHelper
  #  Checks the hidden_meta_fields class variable for a specified field name...
  def show_field?(key)
    !Comatose.config.hidden_meta_fields.include? key
  end
  
  def role_call
    my_roles = []
    current_user.roles.each do |r|
      my_roles.push(r.name)
    end
    return my_roles
  end
  
  # Show all available roles in drop-down
  def show_roles
    @role = Role.name_does_not_equal("user")
    return select(:page, :role_ids, @role.collect {|p| [p.name.capitalize, p.id]})
  end
  
  # Return the admin role by stripping-off the user role from the array
  def admin_role
    r = current_user.role_ids
    r.delete(1)
    
    return r
  end
  
  # Determine if the current_user is an admin or publisher
  def cms_admin?
    current_user.roles.each do |r|
      if r.name == "admin" || r.name == "publisher"
        return true
      end
    end
    return false
  end
  
  # Used in the Page Form to build an indented drop-down list of pages
  def tree_select_box(nodes, selected= nil, hide= nil, label="Parent", add_initial=false)
    level = 0
    select_box = add_initial ? "<option value=0>No #{label}</option>\n" : ""
    selected = nodes[0].id if selected.nil? and not add_initial
    nodes.each {|node| select_box += add_select_tree_node(node, selected, level, hide) }
    select_box += ''
  end
  
  # Called by tree_select_box
  def add_select_tree_node(node, selected, level, hide)
    padding = "&nbsp;" * level * 4
    padding += '&raquo; ' unless level==0
    hide_values = Array.new
    hide_values << hide if hide
    if node.id == selected
      select_box = %Q|<option value="#{node.id}" selected="true">#{padding}#{node.title}</option>\n|
    else
      if hide_values.include?(node.id)
        select_box = ''
      else
        select_box = %Q|<option value="#{node.id}">#{padding}#{node.title}</option>\n|
      end
    end
    node.children.each do |child|
      select_box += add_select_tree_node(child, selected, level + 1, hide) unless hide_values.include?(node.id)
    end
    select_box
  end
  
end