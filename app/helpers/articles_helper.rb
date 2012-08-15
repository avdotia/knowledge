module ArticlesHelper
  def index_table_header name, field, current_field, current_direction
    if current_field == field.to_s and current_direction == 'DESC'
      direction = 'ASC'
      displayed_name = "#{image_tag 'arriba.jpg' } #{name}"
    else
      direction = 'DESC'
      displayed_name = "#{image_tag 'abajo.jpg' } #{name}"
    end
    link_to displayed_name.html_safe, articles_path(order_by: field, direction: direction) 
  end
end
