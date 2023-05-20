class StudentsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :student_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :student_invalid
  def index
    render json: Student.all, status: :ok
  end

  def show
    student = find_student
    render json: student, status: :ok
  end

  def destroy
    student = find_student
    student.destroy
    head :no_content
  end

  def create
    student = Student.create!(student_params)
    render json: student, status: :ok
  end

  private

  def find_student
    Student.find(params[:id])
  end

  def student_not_found
    render json: { error: "Student not found" }, status: :not_found
  end

  def student_params
    params.permit(:name, :major, :age, :instructor_id)
  end

  def student_invalid(invalid)
    render json: { error: invalid.record.errors }, status: :unprocessable_entity
  end
end
