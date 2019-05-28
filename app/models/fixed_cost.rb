class FixedCost < Activity

  def price_calculation
    price / self.num_attendees
  end

end
