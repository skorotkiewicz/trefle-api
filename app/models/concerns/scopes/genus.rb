module Scopes
  module Genus
    extend ActiveSupport::Concern

    included do
      # Filters
      scope :filter_by_family_id, ->(family_id) { where(family_id: family_id) }
      scope :filter_by_name, ->(v) { where('LOWER(name) IN (?)', v) }
      scope :filter_by_slug, ->(v) { where('LOWER(slug) IN (?)', v) }
      # Search
      scope :database_search, lambda {|q|
        where('name ILIKE ?', "%#{q}%")
      }
    end
  end
end
