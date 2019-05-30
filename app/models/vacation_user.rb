class VacationUser < ApplicationRecord
  belongs_to :vacation
  belongs_to :user

  # The role attribute is set to 1 for a vacation owner.
  # It is set to 0 for all other users.s
end
