module DataSanitizer
  class Image
    def self.image_decode(image_url)
      CGI.unescape(image_url).split("url=")[1]
    end
  end
end
