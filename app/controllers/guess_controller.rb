class GuessController < ApplicationController
  include Gender

  # Form to enter in height and weight
  def form
  end

  def guess_parse
    redirect_to guess_path(form_params)
  end

  # Let's make the guess, and see what the user thinks
  def guess
    @height = params[:height].to_f
    @weight = params[:weight].to_f
    @guessed_gender = Gender.calc(@height, @weight)
  end

  def correct
    create_and_save_person(guess_params)
    redirect_to action: 'results'
  end

  def incorrect
    create_and_save_person(guess_params, { flip_gender: true })
    redirect_to action: 'results'
  end

  # Display results on how good the algorithm is
  def results
    # TODO check if save succeeded
  end

  private
    def form_params
      return params.require(:person).permit(:height, :weight)
    end

    def guess_params
      return params.permit(:height, :weight, :guessed_gender)
    end

    def create_and_save_person(params, options = {})
      gender = params[:guessed_gender]
      if options[:flip_gender] then gender = Gender.flip(gender) end

      person = Person.new(height: params[:height], weight: params[:weight],
        gender: gender
      )

      if not person.save!
      end
    end
end
