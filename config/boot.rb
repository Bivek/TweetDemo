require 'rubygems'

# Set up gems listed in the Gemfile.
#setting up
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

#reuire bundler
require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
