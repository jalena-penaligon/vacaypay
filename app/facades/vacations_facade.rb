class VacationsFacade
  attr_reader :vacation_id

  def initialize(vacation_id)
    @vacation_id = vacation_id.to_i
  end

  def vacation_name
    vacation.name
  end

  def vacation_host
    vacation.host.first_name
  end

  def attending_activities(user)
    ids = activities(user).pluck(:activity_id)
    Activity.find(ids)
  end

  def paid?(activity, user)
    find_user_activity(activity, user).paid?
  end

  def user_activity_price(activity, user)
    find_user_activity(activity, user).price
  end

  def outstanding_balance(user)
    vacation.calculate_balance(user)
  end

  def owed_balance(user)
    vacation.calculate_owed_balance(user)
  end

  private

  def find_user_activity(activity, user)
    UserActivity.where(activity_id: activity.id).find_by(user_id: user.id)
  end

  def activities(user)
    UserActivity.where(user_id: user.id)
  end

  def vacation
    @vacation ||= Vacation.find(@vacation_id)
  end

end
