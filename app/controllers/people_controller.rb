class PeopleController < ApplicationController
  # Main view
  def gender_guess
  end

  def create
    @person = Person.new(person_params)

    # TODO check if save succeeded
    @person.save
    render :action => gender_guess
  end

  private
    def person_params
      params.require(:person).permit(:height, :weight, :gender)
    end
end
