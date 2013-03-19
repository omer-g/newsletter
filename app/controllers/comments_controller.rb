class CommentsController < ApplicationController
  before_filter :authenticate

  def index
    @comments = Comment.find_all_by_post_id(params[:post_id])
  end

  def new
    @comment = Comment.new(post_id: params[:post_id])
  end

  def create
    @comment = Comment.create!(params[:comment])
  end

end
