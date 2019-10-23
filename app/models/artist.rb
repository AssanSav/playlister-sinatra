class Artist < ActiveRecord::Base 
    has_many :songs
    has_many :genres, through: :songs

    def slug
        @name = name.split(" ")
        @slug = @name.join("-").downcase
    end

    def self.find_by_slug(slug)
      Artist.all.each do |artist| 
        if artist.slug == slug 
          return artist 
        end
      end
      nil
    end
end