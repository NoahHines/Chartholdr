# Generator.rb
# define class Generator
class Generator
  def initialize(width, height)
    # Instance variables
    @width = width
    @height = height
  end

  def getHTML
    @html_string = ""
    @html_string << "<!DOCTYPE html>"
    @html_string << "<html>"
    @html_string << "<head>"
        @html_string << '<meta charset=' << '"' << 'utf-8' << '"' << '>';
        @html_string << '<link href="../build/nv.d3.css" rel="stylesheet" type="text/css">'
        @html_string << '<script src="https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.2/d3.min.js" charset="utf-8"></script>'
        @html_string << '<script src="../build/nv.d3.js"></script>'
        @html_string << '<script src="lib/stream_layers.js"></script>'

        @html_string << "<style>"
            @html_string << "text {"
                @html_string << "font: 12px sans-serif;"
            @html_string << "}"
            @html_string << "svg {"
                @html_string << "display: block;"
                @html_string << "float: left;"
                @html_string << "height: " + @height.to_s + "px;"
                @html_string << "width: " + @width.to_s + "px;"
            @html_string << "}"
            @html_string << "html, body {"
                @html_string << "margin: 0px;"
                @html_string << "padding: 0px;"
                @html_string << "height: 100%;"
                @html_string << "width: 100%;"
            @html_string << "}"
        @html_string << "</style>"
    @html_string << "</head>"
    @html_string << "<body>"

    @html_string << '<svg id="test1"></svg>'

    @html_string << "<script>"

        @html_string << "var testdata = ["
            @html_string << '{key: "2010", y: 0.55},'
            @html_string << '{key: "2011", y: 0.37},'
            @html_string << '{key: "2012", y: 0.35},'
            @html_string << '{key: "2013", y: 0.41},'
            @html_string << '{key: "2014", y: 0.46},'
            @html_string << '{key: "2015", y: 0.54}'
        @html_string << "];"

        @html_string << "var width = " + @width.to_s + ";"
        @html_string << "var height = " + @height.to_s + ";"

        @html_string << "nv.addGraph(function() {"
            @html_string << "var chart = nv.models.pie()"
                    @html_string << ".width(width)"
                    @html_string << ".height(height);"

            @html_string << 'd3.select(~#test1~)'.to_s.gsub('"', '')
                    @html_string << ".datum([testdata])"
                    @html_string << ".transition().duration(1200)"
                    @html_string << '.attr("width", width)'
                    @html_string << '.attr("height", height)'
                    @html_string << '.call(chart);'

            @html_string << "return chart;"
        @html_string << "});"

    @html_string << "</script>"
    @html_string << "</body>"
    @html_string << "</html>"
    return @html_string.html_safe
  end
  
end