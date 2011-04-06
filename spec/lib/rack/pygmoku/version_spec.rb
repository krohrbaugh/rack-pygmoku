require 'spec_helper'
require 'rack/pygmoku/version'

describe Rack::Pygmoku::Version do

  describe "::STRING" do
    it "is defined" do
      defined?(subject::STRING).should be_true
    end

    it "is a String" do
      subject::STRING.should be_a String
    end

    it "does not end in ." do
      subject::STRING.end_with?('.').should be_false
    end
  end

  describe "::MAJOR" do
    it "is defined" do
      defined?(subject::MAJOR).should be_true
    end

    it "is a Fixnum" do
      subject::MAJOR.should be_a Fixnum
    end
  end

  describe "::MINOR" do
    it "is defined" do
      defined?(subject::MINOR).should be_true
    end

    it "is a Fixnum" do
      subject::MINOR.should be_a Fixnum
    end
  end

  describe "::FIX" do
    it "is defined" do
      defined?(subject::FIX).should be_true
    end

    it "is a Fixnum" do
      subject::FIX.should be_a Fixnum
    end
  end

  describe "::PRE" do
    it "is defined" do
      defined?(subject::PRE).should be_true
    end
  end
end
