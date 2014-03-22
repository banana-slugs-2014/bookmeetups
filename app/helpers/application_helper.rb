module ApplicationHelper

  def logged_in?
    !!session[:id]
  end


end
