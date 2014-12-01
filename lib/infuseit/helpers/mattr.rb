class Module

  # from: rails / activesupport / lib / active_support / core_ext / module / attribute_accessors.rb

  def mattr_reader(*syms)
    options = {}
    syms.each do |sym|
      raise NameError.new("invalid attribute name: #{sym}") unless sym =~ /^[_A-Za-z]\w*$/
      class_eval(<<-EOS, __FILE__, __LINE__ + 1)
        @@#{sym} = nil unless defined? @@#{sym}

        def self.#{sym}
          @@#{sym}
        end
      EOS

      unless options[:instance_reader] == false || options[:instance_accessor] == false
        class_eval(<<-EOS, __FILE__, __LINE__ + 1)
          def #{sym}
            @@#{sym}
          end
        EOS
      end
      class_variable_set("@@#{sym}", yield) if block_given?
    end
  end
  alias :cattr_reader :mattr_reader

  def mattr_writer(*syms)
    options = {}
    syms.each do |sym|
      raise NameError.new("invalid attribute name: #{sym}") unless sym =~ /^[_A-Za-z]\w*$/
      class_eval(<<-EOS, __FILE__, __LINE__ + 1)
        @@#{sym} = nil unless defined? @@#{sym}

        def self.#{sym}=(obj)
          @@#{sym} = obj
        end
      EOS

      unless options[:instance_writer] == false || options[:instance_accessor] == false
        class_eval(<<-EOS, __FILE__, __LINE__ + 1)
          def #{sym}=(obj)
            @@#{sym} = obj
          end
        EOS
      end
      send("#{sym}=", yield) if block_given?
    end
  end
  alias :cattr_writer :mattr_writer

  def mattr_accessor(*syms, &blk)
    mattr_reader(*syms, &blk)
    mattr_writer(*syms, &blk)
  end
  alias :cattr_accessor :mattr_accessor

end