require 'rails_helper'

RSpec.describe 'Examples API', type: :request do
  let(:user)        { create(:user) }
  let!(:examples)   { create_list(:example, 10) }
  let(:example_id)  { examples.first.id }
  let(:headers)     { valid_headers }

  # Create
  describe "POST /examples" do
    let(:valid_attrs) { { example: { name: "Valid Name", content: "Valid Content" } }.to_json }

    context "when valid user signed in" do
      context "when the request is valid" do
        before { post "/examples", params: valid_attrs, headers: headers }

        it "returns status code 201" do
          expect(response).to have_http_status(201)
        end

        it "creates an example" do
          expect(Example.where(name: "Valid Name", content: "Valid Content")).to exist
        end

        it "returns the example object" do
          expect(json['name']).to eq("Valid Name")
          expect(json['content']).to eq("Valid Content")
        end
      end

      context "when the request is invalid" do
        let(:invalid_attrs) { { example: { name: "Invalid Example" } }.to_json }
        before { post "/examples", params: invalid_attrs, headers:headers }

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
  end

  # Read - Multiple
  describe "GET /examples" do
    before { get '/examples' }

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end

    it "returns the requested examples in reverse chronological order" do
      relevant_params = ["id", "name", "content"]
      sorted_examples = examples.sort_by {|e| e["created_at"]}.reverse

      actual          = necessary_info(json, relevant_params)
      expected        = necessary_info(sorted_examples, relevant_params, true)

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
    context "when valid user is signed in" do
      before { get "/examples/validations", headers: headers }

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end

      it "returns a list of validations Example objects" do
        expect(json[0]["validator_type"]).to eq("Presence")
        expect(json[0]["affected_fields"]).to eq(["name", "content"])
      end

    end
  end

  # Update
  describe "PUT /examples/:id" do
    let(:valid_attrs) { { example: { name: "New Name" } }.to_json }

    context "when a valid user is signed in" do
      context "when the record exists" do
        context "when the request is valid" do
          before { put "/examples/#{example_id}", params: valid_attrs, headers: headers }

          it "returns status code 200" do
            expect(response).to have_http_status(200)
          end

          it "updates the example" do
            expect(Example.find(example_id).name).to eq("New Name")
          end

          it "returns the updated example" do
            expect(json['name']).to eq("New Name")
            expect(json['content']).to eq(Example.find(example_id).content)
          end
        end

        context "when the request is invalid" do
          let(:invalid_attrs) { { example: { name: nil } }.to_json }
          before { put "/examples/#{example_id}", params: invalid_attrs, headers: headers }

          it "returns status code 422" do
            expect(response).to have_http_status(422)
          end

          it "does not update the example" do
            expect(json['example']['id']).to eq(example_id)
            expect(json['example']['name']).not_to eq("New Name")
          end

          it "returns a validation failure message" do
            expect(json['errors']).to eq({ "name" => ["can't be blank"] })
          end
        end
      end

      context "when the record does not exist" do
        before { put "/examples/100", params: valid_attrs, headers: headers }

        it "returns status code 404" do
          expect(response).to have_http_status(404)
        end
      end

    end
  end

  # Destroy
  describe "DELETE /examples/:id" do
    context "when a valid user is logged in" do
      context "when the record exists" do
        before { delete "/examples/#{example_id}", headers: headers }

        it "returns status code 204" do
          expect(response).to have_http_status(204)
        end

        it "destroys the example" do
          expect(Example.where(id: examples.last.id)).to exist
          expect(Example.where(id: example_id)).not_to exist
        end
      end

      context "when the record does not exist" do
        before { delete "/examples/100", headers: headers }

        it "returns status code 404" do
          expect(response).to have_http_status(404)
        end
      end
    end
  end
end
