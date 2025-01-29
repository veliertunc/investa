# frozen_string_literal: true

class TextFieldComponent < ViewComponent::Base
  def initialize(form:, field:, type: nil, placeholder: "", **options)
    @form = form
    @field = field
    @type = type || default_type
    @placeholder = placeholder
    @options = options
  end

  def field_class
    class_names(
      "mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500 sm:text-sm",
      @options[:class]
    )
  end
  # { "border-red-300 text-red-900 placeholder-red-300 focus:border-red-500 focus:ring-red-500": error? },

  private

  def default_type
    case @field
    when :email, /email/ then :email
    when :password, /password/ then :password
    else :text
    end
  end
end
