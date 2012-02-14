require_relative '../../app/models/blog'
require 'ostruct'

describe Blog do
  let(:blog) { Blog.new }
  subject { blog }

  its(:title)    { should == "Never enough bits" }
  its(:subtitle) { should == "One never gets enough bits." }

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
      entry = stub.as_null_object
      subject.add_entry(entry)
      subject.entries.should == [entry]
    end
  end

  describe "#entries" do
    it "is empty for a new blog" do
      subject.entries.should be_empty
    end

    it "is sorted in reverse-chronological order" do
      oldest = mock("Entry", :published_at => DateTime.new(2011, 9, 9))
      newest = mock("Entry", :published_at => DateTime.new(2011, 9, 11))
      middle = mock("Entry", :published_at => DateTime.new(2011, 9, 10))

      subject.add_entry(oldest)
      subject.add_entry(newest)
      subject.add_entry(middle)

      subject.entries.should == [newest, middle, oldest]
    end

    it "is limited to 10 posts" do
      10.times do |i|
        subject.add_entry(mock("Entry", :published_at => DateTime.new(2011, 10, i + 1)))
      end
      oldest = mock("Entry", :published_at => DateTime.new(2011, 9, 11))
      subject.add_entry(oldest)
      subject.entries.length.should == 10
      subject.entries.should_not include(oldest)
    end
  end
end
