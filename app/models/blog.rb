class Blog
  attr_writer :post_maker

  def initialize
    @entries = []
  end

  def title
    "Never enough bits"
  end

  def subtitle
    "One never gets enough bits."
  end

  def new_post(*args)
    post_maker.call(*args).tap do |p|
      p.blog = self
    end
  end

  def add_entry(entry)
    @entries << entry
  end

  def entries
    @entries.sort_by(&:published_at).reverse.take(10)
  end

  private
  def post_maker
    @post_maker ||= Post.public_method(:new)
  end
end
