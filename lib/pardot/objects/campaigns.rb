require 'cgi'

module Pardot
  module Objects
    module Campaigns

      def campaigns
        @campaigns ||= Campaigns.new self
      end

      class Campaigns

        def initialize client
          @client = client
        end

        def query search_criteria
          result = get "/do/query", search_criteria, "result"
          result["total_results"] = result["total_results"].to_i if result["total_results"]
          result
        end

        def read_by_id id, params = {}
          post "/do/read/id/#{CGI.escape(id)}", params
        end

        protected

        def get path, params = {}, result = "campaign"
          response = @client.get "campaign", path, params
          result ? response[result] : response
        end

        def post path, params = {}, result = "campaign"
          response = @client.post "campaign", path, params
          result ? response[result] : response
        end

      end

    end
  end
end
