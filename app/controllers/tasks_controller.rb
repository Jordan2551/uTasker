class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # before_action :set_task_additional_params, only: [:edit, :update, :create]
  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.where(user_id: current_user.id)
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    @task.task_type = params[:task_type]
    @task.title = build_title(params[:task_type], params[:task][:course_id])

    # Try to convert the date supplied to a valid date. Otherwise, we use the current dt
    begin
      @task.due_date = DateTime.parse(params[:due_date])
    rescue
      @task.due_date = DateTime.now
    end

    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_path, notice: 'Task was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    @task.task_type = params[:task_type]
    @task.title = build_title(params[:task_type], params[:task][:course_id])
    # Try to convert the date supplied to a valid date. Otherwise, we use the current dt
    begin
      @task.due_date = DateTime.parse(params[:due_date])
    rescue
      @task.due_date = DateTime.now
    end
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_path, notice: 'Task was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update_task_complete
    task = Task.find(params[:id])
    task.is_completed = !task.is_completed

    #Accept the params only nececcary for updating the task status (the task id)
  respond_to do |format|
    if task.update(update_task_status)
      format.html{ redirect_to tasks_path, notice: 'Task status was successfully updated.'}
    else
      format.html{ redirect_to tasks_path, notice: 'Error updating task status!'}
    end
  end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Convinently builds the title for the task using the type of task and the course's code
    def build_title(task_type, course_code)

      course_name = Course.find(course_code).code

      if task_type == '1'
        task_type = 'Assignment in'
      elsif task_type == '2'
        task_type = 'Exam in'
      elsif task_type == '3'
        task_type = 'Quiz in'
      else
        task_type = 'Nothing specified in'
      end

      return "#{task_type} #{course_name}"

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:description, :is_completed, :task_status, :is_priority, :due_date, :user_id, :course_id, :task_type)
    end

    def update_task_status
      params.permit(:id)
    end

end
