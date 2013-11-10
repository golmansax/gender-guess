module Gender
  # Let's store in here the function we use to calculate gender
  def self.calc(height, weight)
    # Manually calculated linear regression model
    # - > 0 is male, < 0 is female
    # - Simulated with male = 1, female = -1
    val = -20.25 + 0.3494 * height + -0.0241 * weight

    return val > 0 ? 'M' : 'F'
  end

  # Flip gender
  def self.flip(gender)
    return gender == 'M' ? 'F' : 'M'
  end
end
