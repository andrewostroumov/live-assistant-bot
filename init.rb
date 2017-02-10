require "bundler"
Bundler.setup

require "telegram/bot"
require "yaml"
require "active_record"
require "mysql2"
require "pry"

require_relative "transaction"

token = "347402719:AAE0RN5rU32-3NmNmhL7I_Fn7nAff5DGn-E"

database_config = YAML.load_file("database.yml")
ActiveRecord::Base.establish_connection(database_config)
ActiveRecord::Base.logger = Logger.new(STDOUT)

Telegram::Bot::Client.run(token, logger: Logger.new(STDOUT)) do |bot|
  bot.listen do |message|
    binding.pry
    next unless message.text
    match_data = message.text.match(/(\d+\.?\d*)\s([[:alnum:]]+)/)
    if match_data
      amount = match_data[1].to_f
      place = match_data[2]
      Transaction.create(amount: amount, place: place)
      bot.api.send_message(chat_id: message.chat.id, text: "OK", reply_markup: { keyboard: [[{ text: "Request Location", request_location: true }]] }.to_json)
    else
      bot.api.send_message(chat_id: message.chat.id, text: "Unable to parse command")
    end
  end
end

# mysql2 rds liveroot:CX8k6nV4vJtH4mk
