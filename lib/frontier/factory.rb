class Frontier::Factory

  include Frontier::ModelProperty

  def to_s
    raw = <<-STRING
FactoryGirl.define do
  factory #{model.name.as_symbol} do
#{render_aligned_and_indented(2, "{", factoried_attributes)}
  end
end
STRING
    raw.rstrip
  end

private

  def render_aligned_and_indented(indents, token, content)
    aligned_content = Frontier::StringAligner.new(content, token).aligned.join("\n")
    render_with_indent(indents, aligned_content)
  end

  def factoried_attributes
    model.attributes.sort_by(&:name).map do |attribute|
      attribute.as_factory_declaration
    end
  end

end
