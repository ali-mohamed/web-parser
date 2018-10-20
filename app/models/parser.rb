require 'readability'
require 'open-uri'
require 'json'
class Parser

  def self.parse_div_contents_into_array(content)
    body = []
    content.children.each do |f|
      if f.name == 'div'
        inner_content = parse_div_contents_into_array(f)
      else
        inner_content = f.inner_html
      end
      body << inner_content if inner_content.length != 0
    end
    body
  end

  def self.parse(url)
    source = open(url).read
    content = Nokogiri::HTML::DocumentFragment.parse(Readability::Document.new(source, remove_empty_nodes: true).content)

    article = { title: Readability::Document.new(source, remove_empty_nodes: true).title }
    article[:content] = parse_div_contents_into_array(content)

    json = article.to_json
  end
end
