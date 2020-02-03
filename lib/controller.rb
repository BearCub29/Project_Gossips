 class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end
  get '/gossips/new/' do
    erb :new_gossip
  end
  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end
  get '/show/:id' do 
    erb :show, locals: {id: params['id'].to_i, gossip: Gossip.find(params['id'].to_i)}
  end
  get '/gossips/*/edit/' do
    erb :edit, locals: { id: params['splat'][0].to_i }
  end
  post '/gossips/*/edit/' do
    Gossip.edit(params['splat'][0].to_i,params["new_author"], params["new_content"])
    redirect "/"
  end
end

