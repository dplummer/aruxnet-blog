require_relative '../../app/models/blog'

describe Blog do
  subject { Blog.new }

  its(:title)    { should == "Never enough bits" }
  its(:subtitle) { should == "One never gets enough bits." }
  its(:entries)  { should be_empty }
end
