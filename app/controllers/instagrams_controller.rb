class InstagramsController < ApplicationController
    before_action :authenticate_user!
    def index
      if params[:search] == nil
        @posts= Instagram.all
      elsif params[:search] == ''
        @posts= Instagram.all
      else
        @posts = Instagram.where("body LIKE ? ",'%' + params[:search] + '%')
      end
      @comment = Comment.new
    end

    def new
        @post= Instagram.new
    end

    def create
        post=Instagram.new(post_params)
        post.user_id = current_user.id
        if post.save
            redirect_to :action => "index"
        else
            redirect_to :action => "new"
        end
    end

    def show
        @post = Instagram.find(params[:id])
        @comments = @post.comments
        @comment = Comment.new
    end
    
    def edit
        @post = Instagram.find(params[:id])

    end

    def update
        post = Instagram.find(params[:id])
        if post.update(post_params)
            redirect_to :action => "show", :id => post.id
        else
            redirect_to :action => "new"
        end
    end

    def destroy
        post = Instagram.find(params[:id])
        post.destroy
        redirect_to action: :index
    end

    def top
    end

    private
    def post_params
        params.require(:instagram).permit(:body,:image)
    end
end