module Infuser

  class Error < StandardError

    def initialize msg
      Infuser.logger.error msg
      super msg
    end

  end

  class ArgumentError < Error; end
  class InvalidConfig < Error; end
  class InvalidKey < Error; end
  class UnexpectedError < Error; end
  class DatabaseError < Error; end
  class RecordNotFound < Error; end
  class LoadingError < Error; end
  class NoTableAccess < Error; end
  class NoFieldAccess < Error; end
  class NoTableFound < Error; end
  class NoFieldFound < Error; end
  class NoFieldsError < Error; end
  class InvalidParameter < Error; end
  class FailedLoginAttempt < Error; end
  class NoAccess < Error; end
  class FailedLoginAttemptPasswordExpired < Error; end

  class ExceptionHandler

    ERRORS = {
      1  => Infuser::InvalidConfig,
      2  => Infuser::InvalidKey,
      3  => Infuser::UnexpectedError,
      4  => Infuser::DatabaseError,
      5  => Infuser::RecordNotFound,
      6  => Infuser::LoadingError,
      7  => Infuser::NoTableAccess,
      8  => Infuser::NoFieldAccess,
      9  => Infuser::NoTableFound,
      10 => Infuser::NoFieldFound,
      11 => Infuser::NoFieldsError,
      12 => Infuser::InvalidParameter,
      13 => Infuser::FailedLoginAttempt,
      14 => Infuser::NoAccess,
      15 => Infuser::FailedLoginAttemptPasswordExpired
    }

    def initialize xmlrpc_exception
      error_class = ERRORS[xmlrpc_exception.faultCode] || Infuser::Error
      raise error_class, xmlrpc_exception.faultString
    end

  end

end
