module Assistant
  class << self
    attr_reader :env

    def groups
      [:default, env]
    end
  end

  @env = ENV["ASSISTANT_ENV"]&.to_sym || :development
end
