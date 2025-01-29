# frozen_string_literal: true

class ComboBoxComponent < ViewComponent::Base
  def initialize(form:, field:, options:, placeholder: "")
    @form = form
    @field = field
    @options = options
    @placeholder = placeholder
  end
end
