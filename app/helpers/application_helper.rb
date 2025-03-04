module ApplicationHelper
  def alert_class(type)
    base = "p-4 mb-4 rounded-lg"
    case type.to_sym
    when :notice then "#{base} bg-green-100 text-green-800"
    when :alert  then "#{base} bg-red-100 text-red-800"
    else "#{base} bg-blue-100 text-blue-800"
    end
  end

  def listing_status_color(status)
    status_color(status)
  end

  def status_badge(status)
    base = "px-3 py-1 rounded-full text-sm"
    "#{base} #{status_color(status)}"
  end

  def status_color(status)
    case status
    # For Listings
    when "active" then "bg-green-100 text-green-800"
    when "funded" then "bg-blue-100 text-blue-800"
    when "closed" then "bg-gray-100 text-gray-800"
    # For Invesmemt Proposals
    when "pending" then "bg-yellow-100 text-yellow-800"
    when "accepted" then "bg-green-100 text-green-800"
    when "rejected" then "bg-red-100 text-red-800"
    else ""
    end
  end
end
