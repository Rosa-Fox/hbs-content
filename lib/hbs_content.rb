require_relative 'hbs_content/version'
require_relative 'hbs_content/contentful_data_provider'

module HbsContent
  DATA_PROVIDER_CLASSES = {
    contentful: ContentfulDataProvider
  }

  def self.configure(provider_key, options = {})
    @provider = DATA_PROVIDER_CLASSES[provider_key].new(options)
  end

  def self.provider
    @provider
  end
end
