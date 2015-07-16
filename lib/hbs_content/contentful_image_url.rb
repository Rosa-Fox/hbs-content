require 'uri'
module HbsContent
  class ContentfulImageUrl
    def initialize(url)
      @url = url
    end

    def to_s
      @url
    end

    def add_parameter(key, value)
      uri = URI(@url)
      new_query_array = URI.decode_www_form(uri.query || '') <<  [key, value]
      uri.query = URI.encode_www_form(new_query_array)
      ContentfulImageUrl.new(uri.to_s)
    end

    def width(width)
      add_parameter 'w', width
    end

    def height(height)
      add_parameter 'h', height
    end

    def fit(fit)
      add_parameter 'fit', fit
    end

    def focus(focus)
      add_parameter 'f', focus
    end

    def background(background)
      add_parameter 'bg', background
    end

    def format(format)
      add_parameter 'fm', format
    end

    def quality(quality)
      add_parameter 'q', quality
    end
  end
end
