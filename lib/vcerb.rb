class VCERB < ActionView::Template::Handlers::ERB
  def load_components
    # TODO eager load all notification components using zeitwerk
    NotificationComponent

    @components ||= ObjectSpace.each_object(Class).select { |c| c < ViewComponent::Base }
  end

  def call(template, source)
    load_components

    @components.each do |component|
      tag_name = component.to_s.sub(/Component\Z/, "")

      # Tag with content
      source.gsub!(%r{<#{tag_name}\s*(?<params>.*?)>(?<body>.*?)</#{tag_name}>}m) do
        body = Regexp.last_match(:body)
        params = Regexp.last_match(:params)

        literal_params = params.scan(/(\w+)="(.*?)"/).map { |k, v| "#{k}: %q{#{v}}" }.join(" ")
        "<%= render #{component}.new(#{literal_params}) do %>#{body}<% end %>"
      end
    end

    super(template, source)
  end
end
