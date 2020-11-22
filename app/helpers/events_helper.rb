module EventsHelper
  def format_price(event)
    event.free? ? "Zero" : number_to_currency(event.price, precision: 0)
  end

  def format_datetime(event)
    event.starts_at.try(:strftime, ("%B %d at %I:%M %P"))
  end

  def register_or_sold_out(event)
    if event.sold_out?
      content_tag(:span, "Sold Out", class: 'sold-out')
    else
      link_to "Register", new_event_registration_path(event), class: 'register'
    end
  end
end