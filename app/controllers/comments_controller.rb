# encoding: utf-8

class CommentsController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @comments = Comment.all
    respond_to do |format|
      format.json {render json: @comments}
      format.html
    end
  end

  def new
    @comment = Comment.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def show
    @comment = Comment.find(params[:id])
    respond_to do |format|
      format.json {render json: @comment}
    end
  end

  def create
    @comment = Comment.new(params[:comment])
    @comment.posted_on = DateTime.now;
    @comment.user = current_user

    if @comment.save
      flash[:notice] = "Комментарий отправлен."
    else
      flash[:alert] = "Упс! С комментарием что-то не так..."
    end

    respond_to do |format|
      format.js
    end
  end

  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.json { head :no_content }
        format.js
      else
        flash[:alert] = "Упс! С комментарием что-то не так..."
        format.json { render json: @comment.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment_id = @comment.id
    @comment.destroy

    respond_to do |format|
      format.json { head :no_content }
      format.js
    end
  end
end
