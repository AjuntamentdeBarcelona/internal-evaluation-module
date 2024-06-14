# frozen_string_literal: true

module Decidim
  module InternalEvaluation
    # This is the engine that runs on the public interface of `InternalEvaluation`.
    class AdminEngine < ::Rails::Engine
      isolate_namespace Decidim::InternalEvaluation::Admin

      paths["db/migrate"] = nil
      paths["lib/tasks"] = nil

      routes do
        # Add admin engine routes here
        # resources :internal_evaluation do
        #   collection do
        #     resources :exports, only: [:create]
        #   end
        # end
        # root to: "internal_evaluation#index"
      end

      def load_seed
        nil
      end
    end
  end
end
