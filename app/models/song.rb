class Song < ActiveRecord::Base
    belongs_to :artist
    has_many :song_genres 
    has_many :genres, through: :song_genres

    def slug 
        raw = name.split(" ")
        @slug = raw.join("-").downcase
        @slug
    end

    def self.find_by_slug(slug)
      Song.all.each do |song| 
        if song.slug == slug 
          return song 
        end
      end
      nil
    end
end