class CommentsController < ApplicationController
  def index
    # @comments = Comment.includes(:user).where(users: { :admin => true }).order("comments.created_at desc")
    @comments = Comment.joins(:user).where(users: { :admin => true }).order("comments.created_at desc")
  end
  
  def show
    @comment = Comment.find(params[:id])
  end
  
  def new
    @comment = Comment.new
  end
  
  def create
    @comment = Comment.new(allowed_params)
    if @comment.save
      flash[:notice] = "Successfully created comment."
      redirect_to @comment
    else
      render :action => 'new'
    end
  end
  
  def edit
    @comment = Comment.find(params[:id])
  end
  
  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(allowed_params)
      flash[:notice] = "Successfully updated comment."
      redirect_to @comment
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = "Successfully destroyed comment."
    redirect_to comments_url
  end
  
  private
  
  def allowed_params
    params.require(:comment).permit!
  end
end
