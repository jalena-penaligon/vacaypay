class VacationUser < ApplicationRecord

  belongs_to :vacation
  belongs_to :user

end
