class SharedActivity

  def activity_name
    activity.name
  end

  def activity_host
    activity.owner
  end

  def attendees
    #possible to make one database query?
    user_ids = UserActivity.where(activity_id: activity.id).pluck(:user_id)
    User.find(user_ids)
  end

  private

  def activity
    @activity ||= Activity.find(@activity_id)
  end

  def vacation
    @vacation ||= Vacation.find(activity.vacation_id)
  end

end
