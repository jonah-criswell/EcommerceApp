require "openai"

OpenAIClient = OpenAI::Client.new(access_token: ENV["OPENAI_ACCESS_KEY"])