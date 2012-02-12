class Blog
  attr_reader :entries

  def initialize
    @entries = []
  end

  def title
    "Never enough bits"
  end

  def subtitle
    "One never gets enough bits."
  end
end
