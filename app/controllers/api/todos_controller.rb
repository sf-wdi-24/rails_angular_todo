class Api::TodosController < ApplicationController
  before_filter :set_todo, except: [:index, :create]

  def index
    @todos = Todo.all.order("created_at DESC")
    render json: @todos
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      render json: @todo
    else
      render json: { errors: @todo.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  def show
    render json: @todo
  end

  def update
    if @todo.update_attributes(todo_params)
      render json: @todo
    else
      render json: { errors: @todo.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  def destroy
    @todo.destroy
    render json: @todo
  end

  private
    def set_todo
      @todo = Todo.find_by(id: params[:id])
    end

    def todo_params
      params.require(:todo).permit(:title, :description, :done)
    end

end