module ApplicationHelper
  def controller_stylesheet_link_tag
    stylesheet = "views/#{params[:controller]}.css"

    if File.exists?(File.join(Rails.public_path, 'stylesheets', stylesheet))
      stylesheet_link_tag stylesheet
    end
  end
end
