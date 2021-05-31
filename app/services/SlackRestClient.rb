class SlackRestClient

    SLACK_URL = "https://hooks.slack.com/services/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"

    def self.postMessage(message )
        response =  RestClient::Request.new({
            method: :post,
            url: SLACK_URL,
            payload: message.to_json,
            headers: {content_type: 'application/json'}

        }).execute do |response, request, result|
            case response.code
            when 400
                puts "error sending message to slack" 
            when 200
                return
            else
              fail "Invalid response #{response.to_str} received."
            end
          end
    end
end
