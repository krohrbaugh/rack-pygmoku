require 'spec_helper'

describe Rack::Pygmoku do
  let(:pygmoku) { Rack::Pygmoku.new(app) }
  let(:app) do
    rack_app = double('app').as_null_object
    rack_app.stub(:call).and_return([status, headers, response])
    rack_app
  end
  let(:status) { 500 }
  let(:headers) { { 'Content-Length' => 0, 'Content-Type' => content_type } }
  let(:content_type) { 'text/plain' }
  let(:response) { Array.new }
  let(:env) { Hash.new }

  #*****************************************************************************
  # Shared example groups
  #*****************************************************************************
  shared_examples_for "the status is immutable" do
    it "does not alter the status" do
      pygmoku.call(env)[0].should == status
    end
  end

  shared_examples_for "Content-Length is set" do
    include Rack::Utils

    it "sets the Content-Length" do
      status, headers, response = pygmoku.call(env)
      content_length = bytesize(response.join).to_s
      headers['Content-Length'] = content_length
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

  #*****************************************************************************
  # Specs
  #*****************************************************************************
  describe "#call" do
    it "responds to #call" do
      pygmoku.should respond_to :call
    end

    context "when the response is 200" do
      let(:status) { 200 }

      context "and the content is HTML" do
        include Specs::HtmlHelper

        let(:content_type) { 'text/html' }

        context "and there are matching elements" do
          let(:response) do
            html = html_doc_containing %Q{
              <pre data-lang='ruby'>
                <code>
                  def hello
                    "Hello World!"
                  end
                </code>
              </pre>
            }
          end
          it_should_behave_like "the status is immutable"
          it_should_behave_like "Content-Length is set"

          it "replaces the highlight element" do
            response = pygmoku.call(env)[2]
            document = Nokogiri::HTML(response.join)
            document.css('pre>code').should be_empty
          end

          it "inserts marked-up div" do
            response = pygmoku.call(env)[2]
            document = Nokogiri::HTML(response.join)
            document.css('div.highlight').should have(1).element
          end
        end

        context "and there are no matching elements" do
          let(:response) do
            html = html_doc_containing %Q{
              <h1>No Code Here!</h1>
            }
          end
          it_should_behave_like "the status is immutable"
          it_should_behave_like "Content-Length is set"

          it "should not add any highlight markup" do
            response = pygmoku.call(env)[2].join
            document = Nokogiri::HTML(response, nil, 'utf-8')
            document.css('div.highlight').should be_empty
          end
        end
      end

      context "and the content is not HTML" do
        let(:content_type) { 'application/xml' }

        it_should_behave_like "pass-through middleware"
      end
    end

    context "when the response is not 200" do
      let(:status) { 301 }

      it_should_behave_like "pass-through middleware"
    end
  end
end
