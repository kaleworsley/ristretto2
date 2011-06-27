module ApplicationHelper

  def show_flash
    content_tag :div, nil, { :id => 'flash' } do
      flash.collect { |index, value| content_tag(:div, value, {:id => "flash-#{index.to_s}"}) }.join.html_safe
    end
  end

end
