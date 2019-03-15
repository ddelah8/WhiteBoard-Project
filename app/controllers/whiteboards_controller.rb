class WhiteboardsController < ApplicationController

    # Might need to change to index 
    def index
      @whiteboards = Whiteboard.all;
    end
  
    def show
        @title = Whiteboard.friendly.find(params[:id]).title
        @whiteboard = Whiteboard.friendly.find(params[:id])
    end
  
    def new 
      @whiteboard = Whiteboard.new
    end

    def create
        @whiteboard = Whiteboard.new(whiteboard_params)
        if @whiteboard.save
            redirect_to controller: 'whiteboards', action: 'show', id: @whiteboard.hash_id
        else
            render :new
        end
    end

    def edit
        @whiteboard = Whiteboard.friendly.find(params[:id])
    end

    def update
        @whiteboard = Whiteboard.friendly.find(params[:id])
        if @whiteboard.update(whiteboard_params)
            redirect_to controller: 'whiteboards', action: 'show', id: @whiteboard.hash_id
        else
            render :edit
        end
    end

    def destroy
        @whiteboard = Whiteboard.friendly.find(params[:id])
        @whiteboard.destroy
        redirect_to controller: 'home', action: 'index'
    end

    def showcable
        ActionCable.server.broadcast 'drawing',
        hash: params[:hash],
        x: params[:x],
        y: params[:y],
        x1: params[:x1],
        y2: params[:y2],
        color1: params[:color1],
        size1: params[:size1],
        highl: params[:highl]
        head :ok
    end
    
    private

    def whiteboard_params
        params.require(:whiteboard).permit(:title, :description)
    end
  
  end
  
