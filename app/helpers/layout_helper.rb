module LayoutHelper
  def flash_messages(opts={})
    @layout_flash = opts.fetch(:layout_flash) { true }

    capture do
      flash.each do |name, msg|        
        concat(content_tag(:div, msg, class: "alert flash-#{name} alert-dismissible", role: "alert") do
          concat content_tag(:button, content_tag(:span, '&times;'.html_safe, aria: { hidden: 'true' }), class: 'close', data: { dismiss: 'alert' }, aria: { label: 'Close' })
          concat content_tag(:p, msg)
        end)
      end
    end
  end

  def show_layout_flash?
    @layout_flash.nil? ? true : @layout_flash
  end

  def controller_name?(controller_name)
    return true if params[:controller] == controller_name
  end  
end