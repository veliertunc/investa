# frozen_string_literal: true

class FormComponent < ViewComponent::Base
  def initialize(model: nil, url: nil, method: :post, title: nil, submit_text: "Submit")
    @model = model
    @url = url
    @method = method
    @title = title
    @submit_text = submit_text
  end
end
