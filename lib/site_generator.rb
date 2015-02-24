class SiteGenerator

  def make_index!

    html = "<!DOCTYPE html>\n<html>\n  <head>\n    <title>Movies</title>\n  </head>\n  <body>\n    <ul>\n"    
    movies = Movie.all

    movies.each do |m|
      html += "      <li><a href=\"movies/#{m.url}\">#{m.title}</a></li>\n"
    end
    
    html += "    </ul>\n  </body>\n</html>"

    File.write("_site/index.html", html)
  end

  def generate_pages!
    # 1. read the source of the template
    html = File.read("lib/templates/movie.html.erb")
    # 2. make it into an ERB instance
    template = ERB.new(html)
    # 3. load some local data required by the template
    movies = Movie.all
    movies.each do |movie|
      src = template.result(binding)
      File.write("_site/movies/#{movie.url}", src)
    end
  end
end