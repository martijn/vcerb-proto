class VCERB < ActionView::Template::Handlers::ERB
  def initialize
    @debug = false
    super
  end

  def call(template, source)
    @components ||= load_components

    @components.each do |component|
      tag_name = component.to_s.sub(/Component\Z/, "")

      # Tag without content
      source.gsub!(%r{<#{tag_name}\s*(?<params>[^/]*)/>}m) do
        puts "\n\n#{Regexp.last_match(:params)}" if @debug
        params = param_literal(Regexp.last_match(:params))

        puts "---" if @debug

        "<!-- Begin #{component} --><%= render #{component}.new(#{params}) %><!-- End #{component} -->"
      end

      # Tag with content
      source.gsub!(%r{<#{tag_name}\s*(?<params>.*?)>(?<body>.*?)</#{tag_name}>}m) do
        puts "\n\n#{Regexp.last_match(:params)}" if @debug
        body = Regexp.last_match(:body)
        params = param_literal(Regexp.last_match(:params))
        puts "---" if @debug

        "<!-- Begin #{component} --><%= render #{component}.new(#{params}) do %>#{body}<% end %><!-- End #{component} -->"
      end
    end

    super(template, source)
  end

  private

  # Convert a string from a view component tag to suitable template output
  def param_literal(str)
    (
      str.scan(%r{(?<key>\w+)={(?<value>.*)}}).map do |key, value|
        puts "Found ruby: #{key} = #{value}" if @debug
        "#{key}: (#{value})"
      end +
      str.scan(%r{(?<key>\w+)="(?<value>.*?)"}).map do |key, value|
        puts "Found string: #{key} = #{value}" if @debug
        "#{key}: #{value.inspect}"
      end
    ).join(", ")
  end

  def load_components
    # Force eager loading of the Rals app in development so we can find the view components in ObjectSpace
    Zeitwerk::Loader.eager_load_all

    ObjectSpace.each_object(Class).select { |c| c < ViewComponent::Base }
  end
end
