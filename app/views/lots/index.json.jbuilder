# frozen_string_literal: true

json.array! @lots, partial: 'lots/lot', as: :lot
