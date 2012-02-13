require 'timecop'
require_relative '../support/stub_module'
stub_module 'ActiveModel::Naming'
stub_module 'ActiveModel::Conversion'

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

  describe "#published_at" do
    describe "before publishing" do
      its(:published_at) { should be_nil }
    end

    describe "after publishing" do
      before(:each) do
        post.blog = stub.as_null_object
      end

      it "sets the publish date to the current time" do
        Timecop.freeze do
          expect do
            subject.publish
          end.to change { subject.published_at }.to(DateTime.now)
        end
      end

      it "sets the publish time to the time passed in" do
        clock = stub
        now = DateTime.new(2011,1,1,1,1,1)
        clock.stub(:now) { now }

        expect do
          subject.publish(clock)
        end.to change { subject.published_at }.to(now)
      end
    end
  end
end
