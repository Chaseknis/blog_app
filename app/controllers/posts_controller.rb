class PostsController < ApplicationController
  layout 'posts'

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
  end

  def new
    @post = Post.new
    @current_user = params[:user_id]
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0
    if @post.save
      flash[:notice] = 'Post was successfully created.'
      redirect_to user_post_path(current_user, @post)
    else
      flash.now[:alert] = 'Post was not created.'
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
<% if @users.empty? %>
    <p>There are no users</p>
<% else %>
    <p class="current-user">Logged in as: <%= current_user.name %></p>
    <%= link_to new_user_post_path(user_id: current_user.id),class:"new-post-btn" do%> 
        <button>
        Create New Post
        </button>
    <% end %>
    <ul id='current-users' >
        <p>Current Users</p>
        <% @users.each do |user| %>
        <li>
            <img src=<%= user.photo %> alt="image">
            <div>
                <h2><%= link_to user.name , {:action => 'show', :id => user.id} %></h2>
                <p>Number of posts: <%= user.posts_counter %> </p>
            </div>
        </li>
        <% end %>
    </ul>
    <button>
        <%= link_to 'Sign out',  destroy_user_session_path, method: :delete %>
    </button>
<% end %>
Innocent N.  to  Everyone 11:21 AM
class PostsController < ApplicationController
  layout 'posts'

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
  end

  def new
    @post = Post.new
    @current_user = params[:user_id]
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0
    if @post.save
      flash[:notice] = 'Post was successfully created.'
      redirect_to user_post_path(current_user, @post)
    else
      flash.now[:alert] = 'Post was not created.'
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
<% if @users.empty? %>
    <p>There are no users</p>
<% else %>
    <p class="current-user">Logged in as: <%= current_user.name %></p>
    <%= link_to new_user_post_path(user_id: current_user.id),class:"new-post-btn" do%> 
        <button>
        Create New Post
        </button>
    <% end %>
    <ul id='current-users' >
        <p>Current Users</p>
        <% @users.each do |user| %>
        <li>
            <img src=<%= user.photo %> alt="image">
            <div>
                <h2><%= link_to user.name , {:action => 'show', :id => user.id} %></h2>
                <p>Number of posts: <%= user.posts_counter %> </p>
            </div>
        </li>
        <% end %>
    </ul>
    <button>
        <%= link_to 'Sign out',  destroy_user_session_path, method: :delete %>
    </button>
<% end %>
