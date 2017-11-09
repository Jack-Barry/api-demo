require 'rails_helper'

RSpec.describe 'Examples API', type: :request do
  let!(:examples)   { create_list(:example, 10) }
  let(:example_id) { examples.first.id }

  # Create
  describe "POST /examples" do
    let(:valid_attrs) { { example: { name: "Valid Name", content: "Valid Content" } } }

    context "when the request is valid" do
      before { post "/examples", params: valid_attrs }

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end

      it "creates an example" do
        expect(Example.where(name: "Valid Name", content: "Valid Content")).to exist
      end
    end

    context "when the request is invalid" do
      before { post "/examples", params: { example: { name: "Invalid Example" } } }

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end

      it "does not add an Example to the database" do
        expect(Example.where(name: "Invalid Example")).not_to exist
      end

      it "returns the submitted Example object" do
        expect(json['example']).to include("name" => "Invalid Example", "content" => nil )
      end

      it "returns a hash of errors" do
        expect(json['errors']).to include("content" => [ "can't be blank" ])
      end
    end
  end

  # Read - Multiple
  describe "GET /examples" do
    before { get '/examples' }

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end

    it "returns the requested examples" do
      relevant_params = ["id", "name", "content"]
      actual          = necessary_info(json, relevant_params)
      expected        = necessary_info(examples, relevant_params, true)

      expect(actual).to eq(expected)
    end
  end

  # Read - Singular
  describe "GET /examples/:id" do
    before { get "/examples/#{example_id}" }

    context "when the record exists" do
      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end

      it "returns the example" do
        expect(json['id']).to eq(example_id)
      end
    end

    context "when the record does not exist" do
      let(:example_id) { 100 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end
    end
  end

  # Read - Validations
  describe "GET /examples/validations" do
    before { get "/examples/validations" }

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end

    it "returns a list of validations Example objects" do
      expect(json[0]["validator_type"]).to eq("Presence")
      expect(json[0]["affected_fields"]).to eq(["name", "content"])
    end
  end

  # Update
  describe "PUT /examples/:id" do
    let(:valid_attrs) { { example: { name: "New Name" } } }

    context "when the record exists" do
      context "when the request is valid" do
        before { put "/examples/#{example_id}", params: valid_attrs }

        it "updates the example" do
          expect(Example.find(example_id).name).to eq("New Name")
        end

        it "returns status code 200" do
          expect(response).to have_http_status(200)
        end

        it "returns the updated example" do
          expect(json['name']).to eq("New Name")
          expect(json['content']).to eq(Example.find(example_id).content)
        end
      end

      context "when the request is invalid" do
        let(:invalid_attrs) { { example: { name: nil } } }
        before { put "/examples/#{example_id}", params: invalid_attrs }

        it "returns a validation failure message" do
          expect(response.body).to include("Name can't be blank")
        end

        it "returns status code 422" do
          expect(response).to have_http_status(422)
        end
      end
    end

    context "when the record does not exist" do
      before { put "/examples/100", params: valid_attrs }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end
    end
  end

  # Destroy
  describe "DELETE /examples/:id" do
    context "when the record exists" do
      before { delete "/examples/#{example_id}" }

      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end
    end

    context "when the record does not exist" do
      before { delete "/examples/100" }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end
    end
  end
end
