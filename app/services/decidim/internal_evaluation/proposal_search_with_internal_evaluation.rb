# frozen_string_literal: true

module Decidim
  module InternalEvaluation
    # This service scopes the proposal searches with parameters that cannot be
    # passed from the user interface.
    class ProposalSearchWithInternalEvaluation < ResourceSearch
      attr_reader :evaluated_by_user

      def build(params)
        return super if search_context != :admin

        @evaluated_by_user = params[:evaluated_by_user]

        if params[:evaluated_by_user] && user
          case params[:evaluated_by_user]
          when "true"
            add_scope(:evaluated_by, user)
          when "false"
            add_scope(:not_evaluated_by, user)
          end
        end

        super
      end
    end
  end
end
