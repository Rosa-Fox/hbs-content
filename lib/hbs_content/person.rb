module HbsContent
  class Person
    attr_accessor :full_name, :title, :home_address, :short_location,
                  :email, :short_bio, :long_bio, :profile_photo_url,
                  :skype_id, :linkedin_url, :github_url, :twitter_url

    def self.all
      provider.all(:person)
    end

    private
    def self.provider
      HbsContent.provider
    end
  end
end
