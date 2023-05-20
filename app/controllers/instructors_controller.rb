class InstructorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :instructor_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :instructor_invalid
  def index
    render json: Instructor.all, status: :ok
  end

  def show
    instructor = find_instructor
    render json: instructor,
           serializer: InstructorWithStudentsSerializer,
           status: :ok
  end

  def destroy
    instructor = find_instructor
    instructor.destroy
    head :no_content
  end

  def update
    instructor = find_instructor
    instructor.update!(instructor_params)
    render json: instructor, status: :ok
  end

  private

  def find_instructor
    Instructor.find(params[:id])
  end

  def instructor_not_found
    render json: { error: "Instructor not found" }, status: :not_found
  end

  def instructor_params
    params.permit(:id, :name)
  end

  def instructor_invalid(invalid)
    render json: { error: invalid.record.errors }, status: :unprocessable_entity
  end
end
