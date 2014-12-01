module Infuseit

  class InfuseitError < StandardError

    def initialize msg
      Infuseit.logger.error "ERROR: #{msg}"
      super msg
    end

  end

  class InvalidConfigError < InfuseitError; end
  class InvalidKeyError < InfuseitError; end
  class UnexpectedError < InfuseitError; end
  class DatabaseError < InfuseitError; end
  class RecordNotFoundError < InfuseitError; end
  class LoadingError < InfuseitError; end
  class NoTableAccessError < InfuseitError; end
  class NoFieldAccessError < InfuseitError; end
  class NoTableFoundError < InfuseitError; end
  class NoFieldFoundError < InfuseitError; end
  class NoFieldsError < InfuseitError; end
  class InvalidParameterError < InfuseitError; end
  class FailedLoginAttemptError < InfuseitError; end
  class NoAccessError < InfuseitError; end
  class FailedLoginAttemptPasswordExpiredError < InfuseitError; end

end
