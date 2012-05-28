require 'context-io/resource'

module ContextIO
  # Webhooks
  #
  # @api public
  class WebHook < Resource

    # @api public
    # @return [Hash] Raw webhook data
    attr_reader :raw_data

    def initialize(account_id, raw_data)
      @account_id = account_id
      @raw_data = raw_data
    end

    # @api public
    # @return [String] Unique webhook id
    def id
      @raw_data['webhook_id']
    end

    # @api public
    # @return [String] The callback url to which ContextIO sends POST data
    def callback_url
      @raw_data['callback_url']
    end

    # @api public
    # @return [String] The callback url to which ContextIO sends failure notifications
    def failure_notify_url
      @raw_data['failure_notif_url']
    end

    # @api public
    # @return [Boolean] Whether the webhook is currently active
    def active?
      @raw_data['active']
    end

    # @api public
    #
    # Creates a new webhook by POSTing raw data to ContextIO
    #
    # @return [Hash] The server response
    def create
      post("/2.0/accounts/#{@account_id}/webhooks", @raw_data)
    end

    # @api public
    #
    # Destroys a webhook by sending a DELETE request. WebHook#id must be set.
    #
    # @return [Hash] The server response
    def destroy
      delete("/2.0/accounts/#{@account_id}/webhooks/#{id}")
    end

    # @api public
    #
    # @return [Array<ContextIO::WebHook>] All currently registered webhooks for the given account.
    def self.all(account, query={})
      account_id = account.respond_to?(:id) ? account.id : account.to_s
      get("/2.0/accounts/#{account_id}/webhooks", query).map do |raw_data|
        ContextIO::WebHook.new(account_id, raw_data)
      end
    end
  end
end
