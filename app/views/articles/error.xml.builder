# frozen_string_literal: true

xml = Builder::XmlMarkup.new({ target: display })

xml.instruct!
xml.html do
  xml.head
  xml.body('User not found')
end
