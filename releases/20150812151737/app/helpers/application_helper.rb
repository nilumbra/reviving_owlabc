module ApplicationHelper
  def deadline
    today = Date.today
    current_month_deadline = DateTime.new(today.year, today.month, 22)
    next_month_deadline = DateTime.new(today.next_month.year, today.next_month.month, 22)
    if today > current_month_deadline
      next_month_deadline
    else
      current_month_deadline
    end
  end
  
  def i18n_attribute_name(collection, elem)
    I18n.t "activerecord.attributes.#{collection.klass.to_s.underscore.downcase}.#{elem}"
  end  

  def format_time(time)
    time.strftime("%m/%d %H:%M")
  end
end
