# http://wiki.rubyonrails.org/rails/pages/HowtoConfigureLogging
module ActiveSupport
  # Used for rails 2.0
  class BufferedLogger
    module Severity
      def level_to_s(level)
        case level
          when 0
          'DEBUG'
          when 1
          'INFO'
          when 2
          'WARN'
          when 3  
          'ERROR'
          when 4
          'FATAL'
          when 5 
          'UNKNOWN'
        end
      end
    end
    
    def add(severity, message = nil, progname = nil, &block)
      return if @level > severity
      message = (message || (block && block.call) || progname).to_s
      # If a newline is necessary then create a new message ending with a newline.
      # Ensures that the original message is not mutated.
      message = "#{message}\n" unless message[-1] == ?\n
      # message = "[%s|#%5d|%s] %s: %s" % [level_to_s(severity)[0..3], $$, Time.now.to_s(:db), progname, message]
      message = "[%s] [%-5s] %s: %s" % [$$, level_to_s(severity), Time.now.to_s(:db), message]
      @buffer << message
      auto_flush
      message
    end
  end
end
