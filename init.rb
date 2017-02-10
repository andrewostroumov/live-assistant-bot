require_relative "boot"
require_relative "transaction"

token = ENV["TELEGRAM_TOKEN"]

database_config = YAML.load_file("database.yml")
logger = Logger.new(STDOUT)

ActiveRecord::Base.establish_connection(database_config)
ActiveRecord::Base.logger = logger

Telegram::Bot::Client.run(token, logger: logger) do |bot|
  bot.listen do |message|
    next unless message.text
    match_data = message.text.match(/(\d+\.?\d*)\s([[:alnum:]]+)/)
    if match_data
      amount = match_data[1].to_f
      place = match_data[2]
      # Transaction.create(amount: amount, place: place)
      # bot.api.send_message(chat_id: message.chat.id, text: "OK", reply_markup: { keyboard: [[{ text: "Request Location", request_location: true }]] }.to_json)
      bot.api.send_message(chat_id: message.chat.id, text: "OK")
    else
      bot.api.send_message(chat_id: message.chat.id, text: "Unable to parse command")
    end
  end
end
