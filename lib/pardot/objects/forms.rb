require 'cgi'

module Pardot
  module Objects
    module Forms

      def forms
        @forms ||= Forms.new self
      end

      class Forms

        def initialize client
          @client = client
        end

        def query search_criteria
          result = get "/do/query", search_criteria, "result"
          result["total_results"] = result["total_results"].to_i if result["total_results"]
          result
        end

        protected

        def get path, params = {}, result = "form"
          response = @client.get "form", path, params
          result ? response[result] : response
        end

      end

    end
  end
end
