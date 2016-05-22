module ApplicationHelper
  #code courtesy of http://railscasts.com/episodes/228-sortable-table-columns?view=asciicast
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = (column == params[:sort] && params[:direction] == "ASC") ? "DESC" : "ASC"
    link_to title, :sort => column, :direction => direction
  end
end
