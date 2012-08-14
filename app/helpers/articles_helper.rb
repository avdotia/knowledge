module ArticlesHelper
  def index_table_header name, field, current_field, current_direction
    if current_field == field.to_s and current_direction == 'DESC'
      direction = 'ASC'
    else
      direction = 'DESC'
    end
    displayed_name = "#{image_tag 'dfasfs' } #{name}"
    link_to displayed_name.html_safe, articles_path(order_by: field, direction: direction) 
  end
end
