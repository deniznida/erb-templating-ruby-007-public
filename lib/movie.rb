require "pry"
class Movie
  @@all = []

  attr_accessor :title, :release_date, :director, :summary

  def initialize (title, release_date, director, summary)
    @title = title
    @release_date = release_date
    @director = director
    @summary = summary
    @@all << self
  end

  def url
    url_title = self.title.downcase.gsub(" ", "_")
    "#{url_title}.html"
  end

  def self.all
    @@all
  end

  def self.reset_movies!
    @@all.clear
  end

  def self.make_movies!
    File.open("spec/fixtures/movies.txt").read.split("\n").each do |m|
      m.split(" - ").tap {|m| Movie.new(m[0], m[1].to_i, m[2], m[3])}
    end
  end

  def self.recent
    self.all.select {|m| m.release_date >= 2012}
  end
end