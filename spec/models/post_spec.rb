require_relative '../../app/models/post'

describe Post do
  let(:post) { Post.new }
  subject { post }

  its(:title) { should be_nil }
  its(:body) { should be_nil }

  it "supports reading and writing the title" do
    subject.title = "foo"
    subject.title.should == "foo"
  end

  it "support reading and writing the body" do
    subject.body = "bar"
    subject.body.should == "bar"
  end

  it "supports reading and writing the blog reference" do
    blog = stub
    subject.blog = blog
    subject.blog.should == blog
  end

  it "supports setting attributes in the initializer" do
    post = Post.new(title: "a title", body: "the body")
    post.title.should == "a title"
    post.body.should == "the body"
  end

  describe "#publish" do
    let(:blog) { mock("Blog") }
    before(:each) do
      post.blog = blog
    end

    it "adds the post to the blog" do
      blog.should_receive(:add_entry).with(subject)
      subject.publish
    end
  end
end
