# frozen_string_literal: true

module ActiveRecordObfuscateId
  class Coder
    attr_reader :prime, :inverse, :random, :maximum

    def initialize(prime:, inverse:, random:, maximum:)
      @prime = prime
      @inverse = inverse
      @random = random
      @maximum = maximum
    end

    def encode(value)
      ((value * prime) & maximum) ^ random
    end

    def decode(value)
      ((value ^ random) * inverse & maximum)
    end
  end
end
