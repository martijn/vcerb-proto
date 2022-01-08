# frozen_string_literal: true

class NotificationComponent < ViewComponent::Base
  def initialize(title:, closeBtn: false)
    @title = title
    @close_btn = closeBtn
  end
end
