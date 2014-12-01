require 'infuseit/exceptions'

class Infuseit::ExceptionHandler

  ERRORS = {
    1  => Infuseit::InvalidConfigError,
    2  => Infuseit::InvalidKeyError,
    3  => Infuseit::UnexpectedError,
    4  => Infuseit::DatabaseError,
    5  => Infuseit::RecordNotFoundError,
    6  => Infuseit::LoadingError,
    7  => Infuseit::NoTableAccessError,
    8  => Infuseit::NoFieldAccessError,
    9  => Infuseit::NoTableFoundError,
    10 => Infuseit::NoFieldFoundError,
    11 => Infuseit::NoFieldsError,
    12 => Infuseit::InvalidParameterError,
    13 => Infuseit::FailedLoginAttemptError,
    14 => Infuseit::NoAccessError,
    15 => Infuseit::FailedLoginAttemptPasswordExpiredError
  }

  def initialize xmlrpc_exception
    error_class = ERRORS[xmlrpc_exception.faultCode] || InfuseitError
    raise error_class, xmlrpc_exception.faultString
  end

end
