class Scrapper
  require 'nokogiri'
  require 'open-uri'

  attr_accessor :body

  LIMIT = 3
  URL = "http://blog.zippycrowd.com"

  def self.fetch!
    doc = Nokogiri::HTML(open(URL))

    articles = doc.search("article").reverse[0..LIMIT - 1]
    articles.collect do |article|
      blog = Scrapper.new
      blog.body = article
      blog
    end
  end

  def entry_title
    @entry_title ||= body.children.search(".entry-title").children.first
  end

  def image_link
    body.children.search("img").first.attributes["src"].value
  end

  def link
    entry_title.attributes["href"].value
  end

  def title
    entry_title.text
  end

  def description
    body.search(".post-meta").text.gsub("\n", "").gsub("\t", "")
  end

end