module ApplicationHelper  
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == params[:sort] && params[:direction] == "asc" ? "desc" : "asc"
    link_to title, :sort => column, :direction => direction
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
