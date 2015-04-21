require 'sinatra'
require 'haml'

class Article
  attr_accessor :title, :body, :number

  def self.article_from_file i
    lines = File.readlines("articles/#{i}.txt")
    title = lines.shift
    body = lines.join("\n")
    article = Article.new
    article.title = title
    article.body = body
    article.number = i
    article
  end

  def self.load_all
    numbers = [1, 2, 3, 4, 5, 6, 7, 8]
    articles_array = numbers.reverse.map{|i|
      article = article_from_file(i)
    }
    return articles_array
  end

  def self.load i
    article_from_file(i)
  end
end

get '/' do
  @articles = Article.load_all

  haml :index
end

get '/articles/:number' do
  @article = Article.load( params[:number] )

  haml :show
end
