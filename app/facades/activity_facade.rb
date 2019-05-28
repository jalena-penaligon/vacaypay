class ActivityFacade < SharedActivity
  attr_reader :activity_id

  def initialize(activity_id)
    @activity_id = activity_id.to_i
  end

  # def attending_activity
  #   ids = activities(user).pluck(:activity_id)
  #   Activity.find(ids)
  # end

  # def outstanding_balance(user)
  #   activities(user).where(paid: false).sum(:price)
  # end

end
