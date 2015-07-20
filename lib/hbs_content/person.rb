module HbsContent
  class Person
    attr_accessor :full_name, :title, :home_address, :short_location,
                  :email, :short_bio, :long_bio, :profile_photo_url,
                  :skype_id, :linkedin_url, :github_url, :twitter_url

    class << self
      def all
        provider.all(:person)
      end

      def for_website_homepage
        provider.people_for_homepage_team_list
      end

      private
      def provider
        HbsContent.provider
      end
    end

  end
end
