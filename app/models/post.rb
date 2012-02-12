class Post
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :title, :body, :blog

  def initialize(attributes = {})
    attributes.each do |attr, val|
      send("#{attr}=", val)
    end
  end

  def publish
    blog.add_entry(self)
  end

  def persisted?
    false
  end
end
