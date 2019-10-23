class Genre < ActiveRecord::Base 
    has_many :song_genres 
    has_many :songs, through: :song_genres
    has_many :artists, through: :songs

    def slug
        @name = name.split(" ")
        @slug = @name.join("-").downcase
    end

    def self.find_by_slug(slug)
      Genre.all.each do |genre| 
        if genre.slug == slug 
          return genre 
        end
      end
      nil
    end
end