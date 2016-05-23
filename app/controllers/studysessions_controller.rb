class StudysessionsController < ApplicationController
  before_action :set_studysession, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  @view_my_sessions =false; #default
  
  
  def redir
    redirect_to studysessions_url
  end  
  helper_method :redir
  
  def is_member? (sess, mem)
    userlist = sess.users
    for i in userlist
      if i == mem
        return true
      end
    end  
    return false;
  end  
  helper_method :is_member?
  
  #named is_leader instead of is_admin to avoid naming conflicts
  def is_leader? (sess, mem)
    userlist = sess.users
    firstuser = userlist[0]
      if firstuser != nil && firstuser.id == mem.id
        return true
      else 
        return false
      end  
  end  
  helper_method :is_leader?
  
  def get_leader(sess)
     userlist = sess.users
     firstuser = userlist[0]
     return firstuser
  end  
  helper_method :get_leader
    
  
  def list_members (sess)
    list = sess.users
    userstr = ""
    length = list.size
    list.each do |user|
      userstr = userstr + user.email
    end  
    return userstr
  end  
  helper_method :list_members
  
  def member_size(sess)
    list = sess.users
    len = list.size
    #str = " #{len} member(s)" 
    return len
  end
  helper_method :member_size
  
  # GET /studysessions/:studysession_id/join_session
  def join_session
    Studysession.find(params[:studysession_id]).users << current_user
    redirect_to studysessions_url
  end  
  helper_method :join_session  
  
  # GET /studysessions/:studysession_id/leave_session
  def leave_session
    Studysession.find(params[:studysession_id]).users.delete(current_user)
    redirect_to studysessions_url
  end
  helper_method :leave_session
  
  def test_multiple_members
    sess = Studysession.create(subject: 'test4', location: 'home4', description: 'des4')
   # user1 = User.create!(email: '13@example.com', password: 'password', password_confirmation: 'password', is_admin: false)
  #  user2 = User.create!(email: '14@example.com', password: 'password', password_confirmation: 'password', is_admin: false)
    sess.users << current_user
    sess.users << User.find(5)
    
  end
  helper_method :test_multiple_members
  
    #used to display only user's sessions (created or joined)
  def my_sessions
    @view_my_sessions = true;
    @mysessions = current_user.studysessions.order("lower(subject) ASC")
    
  end
  helper_method :my_sessions
  
    
  
  # GET /studysessions
  # GET /studysessions.json
  def index
    if params[:my] == 'true'
      if params[:sort] == nil
		    @studysessions = my_sessions
	    else
		    #my sessions, sorted according to parameters
		    @studysessions = Studysession.order("lower(#{params[:sort]})" + " #{params[:direction]}").all 
		    @studysessions = @studysessions.reject{|sess| !is_member?(sess, current_user)}
		  end   
	  else
		  if params[:sort] == nil
			  @studysessions = Studysession.order("lower(subject) ASC").all #default - sort alphabetically
		  else
			  @studysessions = Studysession.order("lower(#{params[:sort]})" + " #{params[:direction]}").all 	
		  end	
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
    @studysession.users << current_user
    respond_to do |format|
      if @studysession.save
        format.html { redirect_to @studysession }
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
        format.html { redirect_to @studysession }
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
      format.html { redirect_to studysessions_url }
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
      params.require(:studysession).permit(:subject, :location, :description, :members)
    end
end
