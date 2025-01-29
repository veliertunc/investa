# frozen_string_literal: true

class ButtonComponent < ViewComponent::Base
  VARIANTS = {
    primary: "bg-blue-600 text-white hover:bg-blue-700",
    secondary: "bg-gray-200 text-gray-700 hover:bg-gray-300",
    danger: "bg-red-600 text-white hover:bg-red-700",
    outline: "border-2 border-gray-300 text-gray-700 hover:bg-gray-50",
    link: "text-blue-600 hover:text-blue-700 underline"
  }.freeze

  SIZES = {
    sm: "px-3 py-1.5 text-sm",
    md: "px-4 py-2 text-base",
    lg: "px-6 py-3 text-lg"
  }.freeze

  def initialize(variant: :primary, size: :md, type: :button, **options)
    @variant = VARIANTS[variant]
    @size = SIZES[size]
    @options = options
    @type = type
    @classes = class_names(
      "inline-flex items-center justify-center rounded-md font-medium transition-colors focus:outline-none focus:ring-2 focus:ring-offset-2",
      @variant,
      @size,
      options[:class]
    )
  end

  # def call
  #   content_tag :button, content, type: @type, class: @classes, **@options.except(:class)
  # end
end
