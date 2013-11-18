module Gender
  puts '*** Initializing Gender module ***'

  # We use the file generated from our daily cron job
  # NOTE: if it is not there, then run the cron job to generate it
  lines = File.readlines('cron/generated-lin_reg_coeffs.txt')
  @a = lines[0].to_f
  @b1 = lines[1].to_f
  @b2 = lines[2].to_f

  # Let's store in here the function we use to calculate gender
  #   @param(height) - should be a number in inches
  #   @param(weight) - should be a number in pounds
  def self.calc(height, weight)
    # Manually calculated linear regression model
    # - > 0 is male, < 0 is female
    # - Simulated with male = 1, female = -1
    val = @a + @b1 * height + @b2 * weight

    return val > 0 ? 'M' : 'F'
  end

  # Flip gender
  def self.flip(gender)
    return gender == 'M' ? 'F' : 'M'
  end
end
