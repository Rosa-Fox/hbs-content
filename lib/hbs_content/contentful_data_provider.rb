require 'contentful'
require_relative 'contentful_image_url'
require_relative 'person'

module HbsContent
  class ContentfulDataProvider
    CONTENT_TYPE_IDS = { person: '6NsnpIaZEssuUCwysAacM4' }
    ENTRY_IDS = { homepage_team_list: '2ASQ8Zlw5WM6waOGO4284y' }

    def initialize(options = {})
      @client = Contentful::Client.new(options)
    end
    
    def all(type)
      entries = @client.entries('content_type' => CONTENT_TYPE_IDS[type])
      entries.map do |entry|
        convert(type, entry)
      end
    end

    def people_for_homepage_team_list
      entries = @client.entry(ENTRY_IDS[:homepage_team_list]).fields[:people].map(&:resolve)
      type    = :person
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
          p.skype_id          = fields[:skypeId]
          p.linkedin_url      = fields[:linkedInUrl]
          p.github_url        = fields[:githubUrl]
          p.twitter_url       = fields[:twitterUrl]

          # Resolve the profile photo URL if required
          profile_photo_field = fields[:profilePhoto].first

          case profile_photo_field.type
          when 'Link'
            profile_photo_field = profile_photo_field.resolve
          when 'Asset'
            # do nothing
          end

          p.profile_photo_url = ContentfulImageUrl.new(profile_photo_field.fields[:file].properties[:url])
        end
      end
    end
  end
end
