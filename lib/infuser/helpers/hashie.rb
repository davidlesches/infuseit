module Infuser
  module Helpers
    module Hashie

      def camelize_hash(hash)
        hash.each_with_object({}) do |(key, value), h|
          camelized_key = get_camelized_key(key)
          h[camelized_key] = value
        end
      end

      def get_camelized_key(key)
        camelized_key = key.to_s.split('_').map{ |w| safe_classify(w)}.join
        remapped_key = model_klass::INFUSIONSOFT_MAPPING[camelized_key] if model_klass
        remapped_key || camelized_key
      end

      def safe_classify w
        w[0] = w[0].upcase; w
      end

    end
  end
end