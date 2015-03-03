module Infuser
  module Helpers
    module Hashie

      def camelize_hash hash
        hash.each_with_object({}) do |(key, value), h|
          h[key.to_s.split('_').map(&:titleize).join] = value
        end
      end

    end
  end
end