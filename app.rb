require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'open-uri'
require 'sinatra/json'
require './models'

enable :sessions

get '/' do
  @articles = Article.order(:id).limit(5)
  erb :index
end

get '/dashboard' do
  unless session[:user] == nil
    user = User.find_by(id: session[:user])
    articles = Article.where(user_id: session[:user])
    @user = user
    @articles = articles
    erb :dashboard
  else
    redirect "/"
  end
end

get '/signin' do
  erb :signin
end
get '/signup' do
  erb :signup
end

get '/signout' do
  session[:user] = nil
  redirect '/'
end

get '/post_article' do
  erb :post_article
end

post '/signup' do
  @user = User.create({
    username: params[:email],
    password: params[:password],
    password_confirmation: params[:password_password_confirmation]
    })

  if @user.persisted?
    session[:user] = @user.id
  end

  redirect '/'
end

post '/signin' do
  user = User.find_by(username: params[:email])
  if user && user.authenticate(params[:password])
          session[:user] = user.id
  end
  redirect '/'
end

post '/post_article' do
  title = params[:title]
  body = params[:body]
  html = params[:html]
  puts body
  file_path = ""
  file_name =  rand(10000).to_s << ".html"
  file_path = "public/" << file_name
  File.open(file_path,"w") do |file|
    file.puts html
  end
  article_url = "http://127.0.0.1:9393/" << file_name
  Article.create({
    title: title,
    body: body,
    user_id: session[:user],
    article_url: article_url
    })
    redirect '/dashboard'
end
post '/delete/:id' do
  Article.find(params[:id]).destroy
  redirect "/dashboard"
end

post '/edit/:id' do
  @article = Article.find(params[:id])
  erb :edit
end

post '/renew/:id' do
  file_path = ""
  file_name =  rand(10000).to_s << ".html"
  file_path = "public/" << file_name
  File.open(file_path,"w") do |file|
    file.puts params[:html]
  end
  article_url = "http://127.0.0.1:9393/" << file_name
    @article = Article.find(params[:id])
    @article.update({
      title: params[:title],
      body: params[:body],
      article_url: article_url
      })
    redirect "/dashboard"
end
post '/edit_profile/:id' do
  @user = User.find(params[:id])
  erb :edit_profile
end
post '/update_profile/:id' do
  @user = User.find(params[:id])
  image_path = ""
  if params[:image]
    image_path = "/images/#{params[:image][:filename]}"
    save_path = "./public" << image_path
    File.open(save_path, "wb") do |f|
      f.write params[:image][:tempfile].read
    end
  end

  @user.update({
    username: params[:email],
    screen_name: params[:screen_name],
    image_url:image_path
    })
    redirect "/dashboard"
end
