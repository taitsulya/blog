# frozen_string_literal: true

xml = Builder::XmlMarkup.new({ target: display })

xml.instruct!
xml.html do
  xml.head do
    xml.title('Blog')
  end
  xml.body do
    xml.h1(@article.title)
    xml.p(@article.body)
  end
end
