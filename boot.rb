require "bundler/setup"

require "active_record"
require "telegram/bot"
require "dotenv/load"
require "yaml"

require_relative "assistant"

require "bundler"
Bundler.require(*Assistant.groups)
