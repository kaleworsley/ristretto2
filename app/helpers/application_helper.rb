module ApplicationHelper

  def show_flash
    content_tag :div, nil, { :id => 'flash' } do
      flash.collect { |index, value| content_tag(:div, value, {:id => "flash-#{index.to_s}"}) }.join.html_safe
    end
  end

  def link_to_with_active(name, options = {}, html_options = {}, &block)
    if current_page?(options)
      class_array = html_options[:class].to_s.split(' ')
      class_array.push('active')
      html_options[:class] = class_array.join(' ')
    end
    link_to name, options, html_options, &block
  end

  def title(page_title, show_title = true)
    content_for(:title) { h(page_title.to_s) }
    @show_title = show_title
  end

  def show_title?
    @show_title
  end

  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args) }
  end

  def javascript(*args)
    content_for(:head) { javascript_include_tag(*args) }
  end

  def show_navigation
    render :partial => 'layouts/navigation'
  end

  def show_subnavigation
    controller_name = controller.controller_name.pluralize
    action_name = controller.action_name
    views_path = Rails.root.join('app', 'views', controller_name)

    if File.exists?("#{views_path}/_#{action_name}_navigation.html.erb") && @subnav
      render :partial => "#{controller_name}/#{action_name}_navigation"
    elsif File.exists?("#{views_path}/_navigation.html.erb") && @subnav
      render :partial => "#{controller_name}/navigation"
    end
  end

end

