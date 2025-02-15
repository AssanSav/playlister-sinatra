require 'sinatra/base'
require 'rack-flash'

class SongsController < ApplicationController

    enable :sessions 
    use Rack::Flash 

    get '/songs' do 
        @songs = Song.all 
        erb :'/songs/index'
    end

    get '/songs/new' do 
        erb :'/songs/new'
    end

    post '/songs' do 
        @song = Song.create(name: params["Name"])
        if @song
            @song.artist = Artist.find_or_create_by(name: params["Artist Name"])
            @song.genre_ids = params["genres"]
            @song.save
            flash[:message] = "Successfully created song."
            redirect ("/songs/#{@song.slug}")
        end
    end
    
    get '/songs/:slug' do 
        @song = Song.find_by_slug(params[:slug])
        erb :'/songs/show'
    end
    
    get '/songs/:slug/edit' do 
        @genres = Genre.all
        @song = Song.find_by_slug(params[:slug])
        erb :'/songs/edit'
    end
    
    patch '/songs/:slug' do 
        @song = Song.find_by_slug(params[:slug])
        if @song 
            @song.artist.update(name: params["Artist Name"])
            @song.genre_ids = params["genres"]
            @song.save
        flash[:message] = "Successfully updated song."
        erb :'/songs/show'
        #binding.pry
        end
    end
end