require 'active_model'

class Post
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :title, :body, :blog, :published_at

  validates :title, presence: true

  def initialize(attributes = {})
    attributes.each do |attr, val|
      send("#{attr}=", val)
    end
  end

  def publish(clock = DateTime)
    return false unless valid?
    self.published_at = clock.now
    blog.add_entry(self)
  end

  def persisted?
    false
  end
end
