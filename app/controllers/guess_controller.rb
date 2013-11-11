class GuessController < ApplicationController
  include Gender

  # Form to enter in height and weight
  def form
    # We maintain a dummy person in case we get invalid height or weight inputs
    if params[:height]
      @height = params[:height]
      @weight = params[:weight]

      dummy_person = make_person_with_dummy_gender(person_params)
      @invalid = !dummy_person.valid?
    end
  end

  # POST layer from form
  def guess_parse
    dummy_person = make_person_with_dummy_gender(form_params)

    if not dummy_person.valid?
      redirect_to form_path(form_params)
    else
      redirect_to guess_path(form_params)
    end
  end

  # Let's make the guess, and see what the user thinks
  def guess
    @height = params[:height].to_f
    @weight = params[:weight].to_f
    @guessed_gender = Gender.calc(@height, @weight)
  end

  # If our guess was correct
  def correct
    create_and_save_person(guess_params)
    redirect_to action: 'results'
  end

  # If our guess was incorrect
  def incorrect
    create_and_save_person(guess_params, { flip_gender: true })
    redirect_to action: 'results'
  end

  # Display results on how good the algorithm is (TODO)
  def results
  end

  private
    def form_params
      return params.require(:person).permit(:height, :weight)
    end

    def guess_params
      return person_params.permit(:guessed_gender)
    end

    def person_params
      return params.permit(:height, :weight)
    end

    def create_and_save_person(params, options = {})
      gender = params[:guessed_gender]
      if options[:flip_gender] then gender = Gender.flip(gender) end

      person = Person.new(height: params[:height], weight: params[:weight],
        gender: gender
      )

      if not person.save
        # TODO what if save fails?
      end
    end

    def make_person_with_dummy_gender(params)
      params[:gender] = 'M'
      return Person.new(params)
    end
end
