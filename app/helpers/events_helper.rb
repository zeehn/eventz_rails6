module EventsHelper
  def format_price(event)
    event.free? ? "Zero" : number_to_currency(event.price, precision: 0)
  end

  def format_datetime(event)
    event.starts_at.try(:strftime, ("%B %d at %I:%M %P"))
  end
end