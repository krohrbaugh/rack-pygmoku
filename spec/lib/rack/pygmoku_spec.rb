require 'spec_helper'

describe Rack::Pygmoku do
  let(:pygmoku) { Rack::Pygmoku.new(app, opts) }
  let(:app) do
    rack_app = double('app').as_null_object
    rack_app.stub(:call).and_return([status, headers, response])
    rack_app
  end
  let(:opts) { {} }
  let(:status) { 500 }
  let(:headers) { { 'Content-Length' => 0, 'Content-Type' => content_type } }
  let(:content_type) { 'text/plain' }
  let(:response) { [] }
  let(:env) { {} }

  shared_examples_for "the status is immutable" do
    it "does not alter the status" do
      pygmoku.call(env)[0].should == status
    end
  end

  shared_examples_for "pass-through middleware" do
    it_should_behave_like "the status is immutable"

    it "does not alter the headers" do
      pygmoku.call(env)[1].should == headers
    end

    it "does not alter the response" do
      pygmoku.call(env)[2].should == response
    end
  end

  shared_examples_for "a code syntax highlighter" do
    it_should_behave_like "the status is immutable"
  end

  describe "#call" do
    it "responds to #call" do
      pygmoku.should respond_to :call
    end

    context "when the response is 200" do
      let(:status) { 200 }

      context "and the content is HTML" do
        let(:content_type) { 'text/html' }

        context "and there are matching elements" do
          it_should_behave_like "a code syntax highlighter"
        end

        context "and there are no matching elements" do
          it_should_behave_like "pass-through middleware"
        end
      end

      context "and the content is XHTML" do
        let(:content_type) { 'application/xml' }

        context "and there are matching elements" do
          it_should_behave_like "a code syntax highlighter"
        end

        context "and there are no matching elements" do
          it_should_behave_like "pass-through middleware"
        end

      end
    end

    context "when the response is not 200" do
      let(:status) { 301 }

      it_should_behave_like "pass-through middleware"
    end
  end
end
