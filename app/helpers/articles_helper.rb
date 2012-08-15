module ArticlesHelper
  def index_table_header name, field, current_field, current_direction
    if current_field == field.to_s and current_direction == 'DESC'
      direction = 'ASC'
    else
      direction = 'DESC'
    end
    n = 0
    if n == 0
      displayed_name = "#{image_tag 'arriba.jpg' } #{name}"
      n = 1
    else
      displayed_name = "#{image_tag 'abajo.jpg' } #{name}"
      n = 0
    end
 #   displayed_name = "#{image_tag 'arriba.jpg' } #{name}"
    link_to displayed_name.html_safe, articles_path(order_by: field, direction: direction) 
  end
end
