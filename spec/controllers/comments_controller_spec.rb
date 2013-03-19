require 'spec_helper'

describe CommentsController do

  before(:each) do
    controller.stub(:authenticate)
  end

  describe "GET 'index'" do
    it "should find all the comments of the post parameter" do
      post = FactoryGirl.create(:post)
      comments_mock = [mock("comment")]
      Comment.should_receive(:find_all_by_post_id).with(post.id).and_return(comments_mock)
      get :index, post_id: post.id, :format => :js
      assigns(:comments).should eq(comments_mock)
    end
  end

  describe "GET 'new'" do
    it "should respond to :js format" do
      get :new, :format => :js
      response.should be_success
    end

    it "should build a new comment object, with the post id parameter" do
      post = FactoryGirl.create(:post)
      comment_mock = mock("comment")
      Comment.should_receive(:new).with(post_id: post.id).and_return(comment_mock)
      get :new, post_id: post.id, :format => :js
      assigns(:comment).should eq(comment_mock)
    end
  end

  describe "POST 'create'" do
    it "should create a comment" do
      post = FactoryGirl.create(:post)
      params = { comment: { post_id: post.id, user_id: post.user.id, body: "Hello" }, :format => :js}
      expect {
      post 'create', params
      }.to change(Comment, :count).by(1)
    end
  end
end