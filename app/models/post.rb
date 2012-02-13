class Post
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :title, :body, :blog, :published_at

  def initialize(attributes = {})
    attributes.each do |attr, val|
      send("#{attr}=", val)
    end
  end

  def publish(clock = DateTime)
    self.published_at = clock.now
    blog.add_entry(self)
  end

  def persisted?
    false
  end
end
