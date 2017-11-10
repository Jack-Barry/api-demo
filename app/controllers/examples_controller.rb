class ExamplesController < ApplicationController
  before_action :set_example, only: [:show, :update, :destroy]

  # POST /examples
  def create
    @example = Example.create(example_params)
    if @example.save
      json_response(@example, :created)
    else
      errors_response(@example)
    end
  end

  # GET /examples
  def index
    @examples = Example.all
    json_response(@examples)
  end

  # GET /examples/:id
  def show
    json_response(@example)
  end

  # GET /examples/validations
  def validations
    @validators = Example.validators.each_with_object([]) do |v, arr|
      hashed_validator = {
        "validator_type":  v.class.name.demodulize.chomp('Validator'),
        "options":         v.options,
        "affected_fields": v.attributes
      }
      arr << hashed_validator
    end

    json_response(@validators)
  end

  # PUT /examples/:id
  def update
    if @example.update(example_params)
      json_response(@example)
    else
      errors_response(@example)
    end
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

  def errors_response(example)
    @payload = {
      example: example,
      errors:  example.errors
    }
    json_response(@payload, :unprocessable_entity)
  end
end
