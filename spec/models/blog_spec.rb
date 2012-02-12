require_relative '../../app/models/blog'
require 'ostruct'

describe Blog do
  let(:blog) { Blog.new }
  subject { blog }

  its(:title)    { should == "Never enough bits" }
  its(:subtitle) { should == "One never gets enough bits." }
  its(:entries)  { should be_empty }

  describe "#new_post" do
    let(:new_post) { OpenStruct.new }

    before(:each) do
      blog.post_maker = ->{ new_post }
    end

    it "returns a new post" do
      subject.new_post.should == new_post
    end

    it "sets the post's blog reference to the blog" do
      subject.new_post.blog.should == blog
    end

    it "accepts an attribute hash on behalf of the post maker" do
      post_maker = mock("Post maker")
      blog.post_maker = post_maker
      post_maker.should_receive(:call).with({x: 42, y: 'z'}).and_return(new_post)
      subject.new_post(x: 42, y: 'z')
    end
  end

  describe "#add_entry" do
    it "adds the entry to the blog" do
      entry = stub
      subject.add_entry(entry)
      subject.entries.should == [entry]
    end
  end
end
