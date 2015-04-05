module Infuser
  module Helpers
    module Hashie

      def camelize_hash(hash, klass_name = nil)
        hash.each_with_object({}) do |(key, value), h|
          camelized_key = get_camelized_key(key, klass_name)
          h[camelized_key] = value
        end
      end

      def get_camelized_key(key, klass_name)
        camelized_key = key.to_s.split('_').map{ |w| safe_classify(w)}.join
        klass = get_klass_name(klass_name)
        remapped_key = klass::INFUSIONSOFT_MAPPING[camelized_key] if klass
        remapped_key || camelized_key
      end

      def get_klass_name(klass_name)
        if klass_name
          Infuser.const_get(klass_name) rescue nil
        end
      end

      def safe_classify w
        w[0] = w[0].upcase; w
      end

    end
  end
end