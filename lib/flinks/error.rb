# frozen_string_literal: true

module Flinks
  class Error < StandardError
    attr_reader :response, :code

    # @param [HTTP::Response] response
    # @return [Flinks::Error]
    def self.from_response(response)
      klass = case response.code
              when 202      then error_for_202(response)
              when 400      then error_for_400(response)
              when 401      then Flinks::Unauthorized
              when 403      then error_for_403(response)
              when 404      then Flinks::NotFound
              when 405      then Flinks::MethodNotAllowed
              when 406      then Flinks::NotAcceptable
              when 409      then Flinks::Conflict
              when 415      then Flinks::UnsupportedMediaType
              when 422      then Flinks::UnprocessableEntity
              when 400..499 then Flinks::ClientError
              when 500      then Flinks::InternalServerError
              when 501      then Flinks::NotImplemented
              when 502      then Flinks::BadGateway
              when 503      then Flinks::ServiceUnavailable
              when 500..599 then Flinks::ServerError
              else
                self
              end

      klass.new(response)
    end

    # @param [HTTP::Response] response
    # @return [Flinks::Error]
    def self.error_for_202(response)
      if response.parse['FlinksCode'] == 'OPERATION_PENDING'
        Flinks::OperationPending
      else
        Flinks::OperationDispatched
      end
    end

    # @param [HTTP::Response] response
    # @return [Flinks::Error]
    def self.error_for_400(response)
      if response.parse['FlinksCode'] == 'SESSION_NONEXISTENT'
        Flinks::SessionNonexistent
      else
        Flinks::BadRequest
      end
    end

    # @param [HTTP::Response] response
    # @return [Flinks::Error]
    def self.error_for_403(response)
      if response.parse['FlinksCode'] == 'TOO_MANY_REQUESTS'
        Flinks::TooManyRequests
      else
        Flinks::Forbidden
      end
    end

    # @param [HTTP::Response] response
    # @return [Flinks::Error]
    def initialize(response)
      @response = response
      @code = response.code

      super(build_message)
    end

    # @return [String]
    def build_message
      message = response.parse['Message']
      message << " - FlinksCode: #{response.parse['FlinksCode']}"
    rescue HTTP::Error
      response.reason
    end
  end

  # Raised when API returns a 202 HTTP status code
  class OperationPending < Error; end

  # Raised when API returns a 202 HTTP status code
  class OperationDispatched < Error; end

  # Raised when API returns a 400..499 HTTP status code
  class ClientError < Error; end

  # Raised when API returns a 400 HTTP status code
  class BadRequest < ClientError; end

  # Raised when API returns a 400 HTTP status code
  class SessionNonexistent < ClientError; end

  # Raised when API returns a 401 HTTP status code
  class Unauthorized < ClientError; end

  # Raised when API returns a 403 HTTP status code
  class Forbidden < ClientError; end

  # Raised when API returns a 403 HTTP status code
  # Rate limit exceeded
  class TooManyRequests < ClientError; end

  # Raised when API returns a 404 HTTP status code
  class NotFound < ClientError; end

  # Raised when API returns a 405 HTTP status code
  class MethodNotAllowed < ClientError; end

  # Raised when API returns a 406 HTTP status code
  class NotAcceptable < ClientError; end

  # Raised when API returns a 409 HTTP status code
  class Conflict < ClientError; end

  # Raised when API returns a 415 HTTP status code
  class UnsupportedMediaType < ClientError; end

  # Raised when API returns a 422 HTTP status code
  class UnprocessableEntity < ClientError; end

  # Raised when API returns a 500..599 HTTP status code
  class ServerError < Error; end

  # Raised when API returns a 500 HTTP status code
  class InternalServerError < ServerError; end

  # Raised when API returns a 501 HTTP status code
  class NotImplemented < ServerError; end

  # Raised when API returns a 502 HTTP status code
  class BadGateway < ServerError; end

  # Raised when API returns a 503 HTTP status code
  class ServiceUnavailable < ServerError; end
end
