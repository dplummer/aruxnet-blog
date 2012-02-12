class Post
  attr_accessor :title, :body, :blog

  def initialize(attributes = {})
    attributes.each do |attr, val|
      send("#{attr}=", val)
    end
  end

  def publish
    blog.add_entry(self)
  end
end
