# frozen_string_literal: true

require "active_support/concern"

module Decidim
  module InternalEvaluation
    module InternalEvaluationAdditions
      extend ActiveSupport::Concern

      included do
        has_many :internal_evaluations,
                 foreign_key: "decidim_proposal_id",
                 class_name: "Decidim::InternalEvaluation::InternalEvaluation",
                 dependent: :destroy

        scope :evaluated_by, lambda { |user|
          joins(:internal_evaluations).where(decidim_internal_evaluation_internal_evaluations: { decidim_author_id: user.id })
        }
        scope :not_evaluated_by, lambda { |user|
          proposals = Decidim::Proposals::Proposal.arel_table
          internal_evaluations = Decidim::InternalEvaluation::InternalEvaluation.arel_table
          join = internal_evaluations.create_join(
            internal_evaluations,
            proposals.create_on(
              internal_evaluations[:decidim_proposal_id]
              .eq(proposals[:id])
              .and(
                internal_evaluations[:decidim_author_id]
              .eq(user.id)
              )
            ),
            Arel::Nodes::OuterJoin
          )

          joins(join).where(
            decidim_internal_evaluation_internal_evaluations: { decidim_author_id: nil }
          )
        }
      end
    end
  end
end
