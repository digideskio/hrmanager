class DepartmentsController < ApplicationController
  before_action :set_department, only: [:show, :edit, :update, :destroy]

  # GET /departments
  # GET /departments.json
  def index
    @departments = Department.all
  end

  # GET /departments/1
  # GET /departments/1.json
  def show
  end

  # GET /departments/new
  def new
    @department = Department.new
    @faculties = Faculty.all
  end

  # GET /departments/1/edit
  def edit
    @faculties = Faculty.all
  end

  # POST /departments
  # POST /departments.json
  def create
    @department = Department.new(department_params)

    respond_to do |format|
      if @department.save
        format.html { redirect_to @department, notice: 'Department was successfully created.' }
        format.json { render action: 'show', status: :created, location: @department }
      else
        @faculties = Faculty.all
        format.html { render action: 'new' }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /departments/1
  # PATCH/PUT /departments/1.json
  def update
    respond_to do |format|
      if @department.update(department_params)
        format.html { redirect_to @department, notice: 'Department was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /departments/1
  # DELETE /departments/1.json
  def destroy
    if @department.employees.empty?
      @department.destroy
      respond_to do |format|
        format.html { redirect_to departments_url }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to :back, :alert => 'Can not delete department. Department has employees.' }
        format.json { head :unprocessable_entity }
      end
    end


  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_department
      @department = Department.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def department_params
      params.require(:department).permit(:name, :faculty_id)
    end
end
