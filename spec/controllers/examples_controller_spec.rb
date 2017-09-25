require 'rails_helper'

RSpec.describe 'Examples API', type: :request do
  let!(:examples)  { create_list(:example, 10) }
  let(:example_id) { examples.first.id }

  describe "GET /examples" do
    before { get '/examples' }

    it "returns examples" do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /examples/:id" do
    before { get "/examples/#{example_id}" }

    context "when the record exists" do
      it "returns the example" do
        expect(json).not_to be_empty
        expect(json['id']).to eq(example_id)
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the record does not exist" do
      let(:example_id) { 100 }

      it "returns a 'not found' message" do
        expect(response.body).to include("Couldn't find Example")
      end

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe "POST /examples" do
    let(:valid_attrs) { { name: "Valid Name", content: "Valid Content" } }

    context "when the request is valid" do
      before { post "/examples", params: valid_attrs }

      it "creates an example" do
        expect(json['name']).to eq("Valid Name")
        expect(json['content']).to eq("Valid Content")
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "when the request is invalid" do
      before { post "/examples", params: { name: "Invalid Example" } }

      it "returns a validation failure message" do
        expect(response.body).to include("Content can't be blank")
      end

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "PUT /examples/:id" do
    let(:valid_attrs) { { name: "New Name" } }

    context "when the record exists" do
      context "when the request is valid" do
        before { put "/examples/#{example_id}", params: valid_attrs }

        it "updates the example" do
          expect(Example.find(example_id).name).to eq("New Name")
        end

        it "returns status code 204" do
          expect(response).to have_http_status(204)
        end
      end

      context "when the request is invalid" do
        let(:invalid_attrs) { { name: 123 } }

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
