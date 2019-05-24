class VacationsFacade
  def initialize(vacation_id)
    @vacation_id = vacation_id
  end

  def vacation_name
    vacation.name
  end

  def vacation_host
    vacation.host.name
  end

  def attending_activities(current_user)
    ids = UserActivity.where(user_id: current_user.id).pluck(:activity_id)
    Activity.find(ids)
  end

  def paid?(activity)
    UserActivity.find_by(activity_id: activity.id).paid?
  end

  private

  def vacation
    @vacation ||= Vacation.find(@vacation_id)
  end

end
