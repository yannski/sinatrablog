require 'sinatra'
require 'haml'

class Article
  attr_accessor :title, :body

  def self.load_all
    numbers = [1, 2, 3, 4, 5, 6, 7, 8]
    articles_array = numbers.map{|i|
      lines = File.readlines("articles/#{i}.txt")
      title = lines.shift
      body = lines.join("\n")
      article = Article.new
      article.title = title
      article.body = body
      return article
    }
    return articles_array
  end
end

get '/' do
  @articles = Article.load_all

  haml :index
end
