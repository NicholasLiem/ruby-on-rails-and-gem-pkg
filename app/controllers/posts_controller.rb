require 'test_api_gem'

class PostsController < ApplicationController
    # GET /posts
    # Fetch all posts
    def index
      @posts = Post.all
      render json: @posts
    end
  
    # GET /posts/:id
    # Fetch a single post
    def show
        @post = Post.find(params[:id])
        
        # Use TestApiGem for additional processing or logging
        processed_post = TestApiGem.process_post_data(@post)
    
        # You can choose to render the original @post or the processed_post
        # depending on what process_post_data does and what you want to show.
        render json: processed_post
    rescue ActiveRecord::RecordNotFound
        render json: { error: "Post not found" }, status: :not_found
    end
    # POST /posts
    # Create a new post
    def create
      @post = Post.new(post_params)
      if @post.save
        render json: @post, status: :created, location: @post
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /posts/:id
    # Update a post
    def update
      @post = Post.find(params[:id])
      if @post.update(post_params)
        render json: @post
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /posts/:id
    # Delete a post
    def destroy
      @post = Post.find(params[:id])
      @post.destroy
      head :no_content
    end
  
    private
  
    # Strong parameters for post
    def post_params
      params.require(:post).permit(:title, :content)
    end
  end
  