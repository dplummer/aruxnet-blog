require 'spec_helper'

describe PostsController do
  describe "new" do
    it "assigns a new post to @post" do
      new_post = stub
      THE_BLOG.stub(:new_post) { new_post }
      get :new
      assigns[:post].should == new_post
    end
  end

  describe "#create" do
    it "builds the post with the params" do
      new_post = stub.as_null_object
      params = {"title" => "x"}
      THE_BLOG.should_receive(:new_post).with(params).and_return(new_post)
      post :create, post: params
    end

    it "assigns the post to @post" do
      new_post = stub.as_null_object
      THE_BLOG.stub(:new_post) { new_post }
      post :create
      assigns[:post].should == new_post
    end

    it "redirects to the root with a notice if successful" do
      new_post = stub(publish: true)
      THE_BLOG.stub(:new_post) { new_post }
      post :create
      response.should redirect_to(root_path)
      flash[:notice].should == "Post added!"
    end

    it "renders the new action if the publish is unsuccessful" do
      new_post = stub(publish: false)
      THE_BLOG.stub(:new_post) { new_post }
      post :create
      response.should render_template('new')
    end
  end
end
