module ApplicationHelper
  def listing_status_color(status)
    case status
    when "active" then "bg-green-100 text-green-800"
    when "funded" then "bg-blue-100 text-blue-800"
    when "closed" then "bg-gray-100 text-gray-800"
    end
  end

  def alert_class(flash_type)
    base = "p-4 mb-4 rounded-lg"
    case flash_type.to_sym
    when :notice then "#{base} bg-green-100 text-green-800"
    when :alert then "#{base} bg-red-100 text-red-800"
    else "#{base} bg-blue-100 text-blue-800"
    end
  end

  def button_class(variant = :primary)
    base = "inline-flex items-center px-4 py-2 border rounded-md shadow-sm text-sm font-medium focus:outline-none focus:ring-2 focus:ring-offset-2"
    case variant
    when :primary
      "#{base} bg-indigo-600 text-white hover:bg-indigo-700 focus:ring-indigo-500"
    when :secondary
      "#{base} bg-gray-100 text-gray-700 hover:bg-gray-200 focus:ring-gray-500"
    when :danger
      "#{base} bg-red-600 text-white hover:bg-red-700 focus:ring-red-500"
    end
  end

  def textfield_class(variant = :text)
    "mt-1 block rounded-md border-indigo-300 ring-indigo-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500"
    # case variant
    # when :text
    #   "#{base} "
    # else
    #   "#{base} "
    # end
  end
end
