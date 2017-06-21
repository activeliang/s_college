class PostsController < ApplicationController
  # before_action :auth_buyer
  def show
    @post = Post.find(params[:id])
    @chapter = @post.chapter
    @lesson = @chapter.lesson
    posts = @lesson.posts


    i = posts.index(@post)

    if posts.first == @post

      @left = nil
      @right = posts[ i + 1 ].id
    elsif posts.last == @post
      @left = posts[ i - 1 ].id
      @right = nil
    else
      @left = posts[ i - 1 ].id
      @right = posts[ i + 1 ].id
    end
  end

  def upvote
    @post = Post.find(params[:id])
    @post.update_column :so_easy, @post.so_easy +=1
    # render :json => "ok"
  end

  def downvote
    @post = Post.find(params[:id])
    @post.update_column :okay, @post.okay +=1
    # render :json => "ok"
  end

end
