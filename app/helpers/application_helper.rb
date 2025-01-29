module ApplicationHelper
  def listing_status_color(status)
  case status
  when "active" then "bg-green-100 text-green-800"
  when "funded" then "bg-blue-100 text-blue-800"
  when "closed" then "bg-gray-100 text-gray-800"
  else "bg-gray-100 text-gray-800"
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


  # Button Component
  def tw_button(options = {}, &block)
    base_classes = "inline-flex items-center border border-transparent font-medium rounded-md transition-colors focus:ring-2"
    size_classes = case options[:size]
    when :sm then "px-3 py-1.5 text-sm"
    when :lg then "px-6 py-3 text-base"
    else "px-4 py-2 text-sm"
    end

    variant_classes = case options[:variant]
    when :primary then "text-white bg-blue-600 hover:bg-blue-700 focus:ring-blue-500"
    when :secondary then "text-gray-700 bg-gray-100 hover:bg-gray-200 focus:ring-gray-500"
    when :danger then "bg-red-600 text-white hover:bg-red-700 focus:ring-red-500"
    else ""
    end

    classes = [ base_classes, size_classes, variant_classes, options[:class] ].compact.join(" ")

    content_tag(:button, class: classes, **options.except(:variant, :size, :class), &block)
  end

  # Form Wrapper
  def tw_form(model, title: nil, classes: "", &block)
    form_with(model: model, class: "space-y-6 #{classes}") do |form|
      content = []
      content << content_tag(:h3, title, class: "text-lg font-medium leading-6 text-gray-900") if title.present?
      content << content_tag(:div, class: "space-y-4", &block)
      safe_join(content)
    end
  end

  # Text Field
  def tw_text_field(form, name, placeholder: "", **options)
    content_tag :div, class: "mb-4" do
      safe_join([
        form.label(name, class: "block text-sm font-medium text-gray-700 mb-1"),
        form.text_field(name, {
          class: "mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500 sm:text-sm #{options[:class]}",
          placeholder: placeholder
        }.merge(options.except(:class)))
      ])
    end
  end

  # Combo Box (Select)
  def tw_combo_box(form, name, options, placeholder: "", **html_options)
    content_tag :div, class: "mb-4" do
      safe_join([
        form.label(name, class: "block text-sm font-medium text-gray-700 mb-1"),
        content_tag(:div, class: "relative") do
          form.select(name, options, { include_blank: placeholder }, {
            class: "mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500 sm:text-sm #{html_options[:class]}",
            data: { controller: "dropdown" }
          }.merge(hrml_options.except(:class)))
        end
      ])
    end
  end

  # Navbar
  def tw_navbar(logo_text: "Your Logo", menu_items: [], **options)
    content_tag :nav, class: "bg-white shadow-sm #{options[:class]}" do
      content_tag :div, class: "mx-auto max-w-7xl px-4 sm:px-6 lg:px-8" do
        content_tag :div, class: "flex h-16 justify-between items-center" do
          safe_join([
            # Logo
            content_tag(:div, class: "flex-shrink-0") do
              link_to root_path, class: "text-xl font-bold text-gray-900 hover:text-gray-700" do
                logo_text
              end
            end,

            # Desktop Menu
            content_tag(:div, class: "hidden md:flex space-x-8") do
              safe_join(menu_items.map { |item|
                link_to item[:text], item[:path], class: nav_link_classes(item[:path])
              })
            end,

            # Mobile Menu Button
            content_tag(:button,
              class: "md:hidden p-2 rounded-md text-gray-700 hover:bg-gray-100",
              data: { action: "click->navbar#toggleMenu" }) do
              "<svg class='h-6 w-6' fill='none' viewBox='0 0 24 24' stroke='currentColor'>
                <path stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M4 6h16M4 12h16M4 18h16' />
              </svg>".html_safe
            end
          ])
        end
        # Mobile Menu
        content_tag(:div,
          class: "md:hidden hidden",
          data: { "navbar-target": "mobileMenu" }) do
          content_tag(:div, class: "px-2 pt-2 pb-3 space-y-1") do
            safe_join(menu_items.map { |item|
              link_to item[:text], item[:path], class: "block px-3 py-2 rounded-md text-base font-medium text-gray-700 hover:bg-gray-100"
            })
          end
        end
      end
    end
  end

  private

  def nav_link_classes(path)
    base = "text-gray-700 hover:text-blue-600 px-3 py-2 rounded-md text-sm font-medium"
    current_page?(path) ? "#{base} bg-blue-50 text-blue-700" : base
  end
end
