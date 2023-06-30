require 'telegram/bot'

Telegram::Bot::Client.run(ENV['TELEGRAM_TOKEN']) do |bot|
  $telegram_bot = bot
end


