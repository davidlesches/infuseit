module Infuser
  module Helpers
    module Hashie

      def camelize_hash hash
        hash.each_with_object({}) do |(key, value), h|
          h[key.to_s.split('_').map { |w| safe_classify(w) }.join] = value
        end
      end

      def safe_classify w
        w[0] = w[0].upcase; w
      end

    end
  end
end