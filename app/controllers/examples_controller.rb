class ExamplesController < ApplicationController
  before_action :set_example, only: [:show, :update, :destroy]

  # GET /examples
  def index
    @examples = Example.all
    json_response(@examples)
  end

  # GET /examples/:id
  def show
    json_response(@example)
  end

  # POST /examples
  def create
    @example = Example.create!(example_params)
    json_response(@example, :created)
  end

  # PUT /examples/:id
  def update
    @example.update!(example_params)
    json_response(@example)
  end

  # DELETE /examples/:id
  def destroy
    @example.destroy
    head :no_content
  end

  private

  def example_params
    params.require(:example).permit(:name, :content)
  end

  def set_example
    @example = Example.find(params[:id])
  end
end
