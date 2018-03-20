# frozen_string_literal: true

module ActiveRecordObfuscateId
  class Coder
    def initialize(prime:, random:, maximum:)
      @prime = prime
      @random = random
      @maximum = maximum
    end

    def encode(value)
      value
    end

    def decode(value)
      value
    end
  end
end
