module ApplicationHelper
  def alert_class(type)
    case type.to_sym
    when :notice then "alert-info"
    when :alert  then "alert-error"
    else ""
    end
  end

  def status_badge(status)
    base = "badge"
    case status
    # For Listings
    when "active" then "#{base} badge-info"
    when "funded" then "#{base} badge-success"
    when "closed" then "#{base} badge-error"
    # For Invesmemt Proposals
    when "pending" then "#{base} badge-warning"
    when "accepted" then "#{base} badge-success"
    when "rejected" then "#{base} badge-error"
    end
  end
end
