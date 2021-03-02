class FiguresController < ApplicationController
  # add controller methods
  get '/figures' do
    @figures = Figure.all

    erb :'/figures/index'
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all

    erb :'/figures/new'
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])

    if !params[:new_landmark][:name].empty? || !params[:new_title][:name].empty? 
      landmark = @figure.landmarks.create(params[:new_landmark])
      title = @figure.titles.create(params[:new_title])
    end

    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by(params[:id])
    @figure_name = @figure.name
    @figure_id = @figure.id
    @titles = Title.all
    @title = Title.find_by(params[:id])
    @landmark = Landmark.find_by(params[:id])
    @landmark_name = @landmark.name
    @figures = Figure.all

    erb :"/figures/edit"
  end

  get '/figures/:id' do
    @figure = Figure.find_by(params[:id])
    @titles = Title.all
    erb :"/figures/show"
  end

  patch '/figures/:id' do

    @figure = Figure.find_by(id: params[:id])
    @figure.update(params[:figure])

    if !params[:title][:name].empty?
      @figure.titles.create(params[:title]) 
    end
    if !params[:landmark][:name].empty?
      @figure.landmarks.create(params[:landmark])
    end

    redirect "/figures/#{@figure.id}"
  end

end
