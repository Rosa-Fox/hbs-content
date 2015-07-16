require 'contentful'
require_relative 'contentful_image_url'
require_relative 'person'

module HbsContent
  class ContentfulDataProvider
    CONTENT_TYPE_IDS = { person: '6NsnpIaZEssuUCwysAacM4' }

    def initialize(options = {})
      @client = Contentful::Client.new(options)
    end
    
    def all(type)
      entries = @client.entries('content_type' => CONTENT_TYPE_IDS[type])
      entries.map do |entry|
        convert(type, entry)
      end
    end

    def convert(type, entry)
      fields = entry.fields
      case type
      when :person
        Person.new.tap do |p|
          p.full_name         = fields[:fullName]
          p.title             = fields[:title]
          p.home_address      = fields[:homeAddress]
          p.short_location    = fields[:shortLocation]
          p.email             = fields[:email]
          p.short_bio         = fields[:shortBio]
          p.long_bio          = fields[:longBio]
          p.profile_photo_url = ContentfulImageUrl.new(fields[:profilePhoto].first.fields[:file].properties[:url])
          p.skype_id          = fields[:skypeId]
          p.linkedin_url      = fields[:linkedInUrl]
          p.github_url        = fields[:githubUrl]
          p.twitter_url       = fields[:twitterUrl]
        end
      end
    end
  end
end
