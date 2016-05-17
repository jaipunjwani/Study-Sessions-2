class StudysessionsController < ApplicationController
  before_action :set_studysession, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def session_member? (sess, mem)
    userlist = sess.users
    userlist.each do |user|
      if mem.id == user.id
        return true
      end
    end  
    return false;
  end  
  helper_method :session_member?
  
  def list_members (sess)
    list = sess.users
    userstr = ""
    list.each do |user|
      userstr = userstr + user.email
    end  
    return userstr
  end  
  helper_method :list_members
  
  def join_session(sess, member)
    sess.users << member
  end  
  helper_method :join_session  
  
    
  
  # GET /studysessions
  # GET /studysessions.json
  def index
    @studysessions = Studysession.all
    @userlist =[]
    index =0
    @studysessions.each do |session|
      @userlist[index] = session.users
      index = index + 1
    end
  end

  # GET /studysessions/1
  # GET /studysessions/1.json
  def show
  end

  # GET /studysessions/new
  def new
    @studysession = Studysession.new
  end

  # GET /studysessions/1/edit
  def edit
  end

  # POST /studysessions
  # POST /studysessions.json
  def create
    @studysession = Studysession.new(studysession_params)
   #studysession = current_user.studysessions.new(studysession_params)
    @studysession.users << current_user
    respond_to do |format|
      if @studysession.save
        format.html { redirect_to @studysession, notice: 'Studysession was successfully created.' }
        format.json { render :show, status: :created, location: @studysession }
      else
        format.html { render :new }
        format.json { render json: @studysession.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /studysessions/1
  # PATCH/PUT /studysessions/1.json
  def update
    respond_to do |format|
      if @studysession.update(studysession_params)
        format.html { redirect_to @studysession, notice: 'Studysession was successfully updated.' }
        format.json { render :show, status: :ok, location: @studysession }
      else
        format.html { render :edit }
        format.json { render json: @studysession.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /studysessions/1
  # DELETE /studysessions/1.json
  def destroy
    @studysession.destroy
    respond_to do |format|
      format.html { redirect_to studysessions_url, notice: 'Studysession was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_studysession
      @studysession = Studysession.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def studysession_params
      params.require(:studysession).permit(:subject, :location, :description)
    end
end
