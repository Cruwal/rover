require 'active_support'

module BaseService
  extend ActiveSupport::Concern

  class_methods do
    def call(*args, &block)
      new(*args, &block).call
    end
  end
end
