require 'nokogiri'

module Rack
  class Pygmoku
    def initialize(app, opts={})
      @app = app
    end

    def call(env)
      @app.call(env)
    end
  end
end
