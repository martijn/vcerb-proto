require 'vcerb'

ActionView::Template.register_template_handler :vcerb, VCERB.new
