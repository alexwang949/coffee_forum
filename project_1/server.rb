require 'sinatra'
require 'pry'
require './lib/categories_class.rb'
require './lib/post_class.rb'
require './lib/comment_class.rb'
require './lib/connection.rb'
require './lib/test_1.rb'
require 'date'
require 'mustache'
require 'sinatra/reloader'
require 'will_paginate'
require 'will_paginate/active_record'


# title page

get '/' do 
	File.read('./view/title_page.html')
end

# view all categories

get '/categories' do 	
	categories = Category.all.to_a
	posts = Post.all.to_a
	Mustache.render(File.read('./view/all_categ.html'), {block: categories, block_1: posts})
end



# add category form

get '/categories/new' do 
	File.read('./forms/categ_form.html')
end


post '/categories/new' do 
	File.read('./forms/categ_form.html')
	new_category = Category.create(title: params[:form_category_title], description: params[:form_description])
	new_category.save
	redirect '/categories'
end

#delete single category

delete '/categories/:categ_name' do 
	find_category = Category.find_by(title: params[:categ_name])
	Category.destroy(find_category)
	redirect '/categories'
end

#create new post

get '/categories/:categ_name/new_post' do 
	File.read('./forms/post_form.html')
	find_categ = Category.find_by(title: params[:categ_name])
	rendered = Mustache.render(File.read('./forms/post_form.html'), {block: find_categ})
end

post '/categories/:categ_name/new_post' do
	date = Date.today
	variable = params[:categ_name]
	new_post = Post.create(category: params[:categ_name], post_title: params[:title], entry: params[:entry], date: date)
	new_post.save
	redirect '/categories'
end 
# binding.pry


# view single category

get '/categories/:categ_name' do 
	single_category = Category.find_by(title: params[:categ_name])
	posts = Post.where(category: params[:categ_name]).to_a
	Mustache.render(File.read('./view/single_categ.html'), {block: single_category, block_1: posts})
end

# view single post

get '/categories/:categ_name/:id_post' do 
	single_post = Post.where(category: params[:categ_name], id: params[:id_post]).to_a
	comments = Comment.where(post_id: params[:id_post]).to_a
	Mustache.render(File.read('./view/single_post.html'), {block: single_post, block_1: comments})
end

# delete single post

delete '/categories/:categ_name/:id_post' do 
	single_post = Post.where(category: params[:categ_name], id: params[:id_post])
	Post.destroy(single_post) 		
	redirect 
end

# Reply new comment

get '/categories/:categ_name/:id_post/comment' do 
	File.read('./forms/comment_form.html')
	post_find = Post.find_by(category: params[:categ_name], id: params[:id_post])
	Mustache.render(File.read('./forms/comment_form.html'), {block: post_find})
end

post '/categories/:categ_name/:id_post/comment' do 
	File.read('./forms/comment_form.html')
	date = Date.today
	new_comment = Comment.create(user_name: params[:comment_user_name], date: date, entry: params[:comment_entry], post_id: params[:id_post])
	new_comment.save
	redirect('/categories')
end

#### VOTE FOR CATEGORY #####

put '/categories/:categ_name/vote' do 
	category_find = Category.find_by(title: params[:categ_name])
	id_find = category_find["id"]
	votes_add = category_find["votes"].to_i + 1
	Category.update(id_find, votes: votes_add)
	redirect back
end

put '/categories/:categ_name/vote_down' do 
	category_find = Category.find_by(title: params[:categ_name])
	id_find = category_find["id"]
	votes_add = category_find["votes"].to_i - 1
	Category.update(id_find, votes: votes_add)
	redirect back
end

### VOTE FOR POST #####

put '/categories/:categ_name/:id_post/vote' do 
	post_find = Post.find_by(category: params[:categ_name], id: params[:id_post])
	id_find = post_find["id"]
	votes_add = post_find["votes"].to_i + 1
	Post.update(id_find, votes: votes_add)
	redirect back
end

put '/categories/:categ_name/:id_post/vote_down' do 
	post_find = Post.find_by(category: params[:categ_name], id: params[:id_post])
	id_find = post_find["id"]
	votes_minus = post_find["votes"].to_i - 1
	Post.update(id_find, votes: votes_minus)
	redirect back
end


