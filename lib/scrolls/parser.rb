require 'time'

module Scrolls
  module Parser
    extend self

    def parse(data, escape_keys=false)
      result = {}

      data.map do |(key,v)|
        key = Scrolls::Utils.escape_chars(key) if escape_keys

        if key.is_a?(Symbol)
          key = key.to_s
        end

        if v.is_a?(Time)
          result[key] = v.iso8601
        elsif v.is_a?(String)
          result[key] = v.dup.force_encoding('UTF-8')
        elsif v.is_a?(Hash)
          result[key] = parse(v)
        else
          result[key] = v
        end
      end

      result
    end
  end
end
