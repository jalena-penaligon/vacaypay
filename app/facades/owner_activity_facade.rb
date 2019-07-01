class OwnerActivityFacade < SharedActivity
  attr_reader :activity_id

  def initialize(activity_id)
    @activity_id = activity_id.to_i
  end
end
