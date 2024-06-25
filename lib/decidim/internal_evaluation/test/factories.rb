# frozen_string_literal: true

require "decidim/components/namer"
require "decidim/core/test/factories"

FactoryBot.define do
  factory :internal_evaluation_component, parent: :component do
    name { Decidim::Components::Namer.new(participatory_space.organization.available_locales, :internal_evaluation).i18n_name }
    manifest_name { :internal_evaluation }
    participatory_space { association(:participatory_process, :with_steps) }
  end

  # Add engine factories here
end
