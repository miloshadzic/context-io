require 'context-io/error/server_error'

module ContextIO
  # Raised when Context.IO returns the HTTP status code 500.
  #
  # @api public
  class Error::InternalServerError < ContextIO::Error::ServerError
  end
end

