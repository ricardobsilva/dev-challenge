class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /users
  # GET /users.json
  def friend
    @friends = Friendship.paginate(:page => params[:page], :per_page => 5).where(user_id: current_user).where(aproved: 'yes')
    #@friends_g = Friendship.paginate(:page => params[:page], :per_page => 5).where(user_id: current_user)
   # @friends = @friends_g.select("DISTINCT(friend_id)")
  end

  def index
    #@users = Friendship.where(user_id: current_user)
    @users = User.paginate(:page => params[:page], :per_page => 5)
  end

  #criar amizade
  def cfriend
    # cria a amizade bilateral
    Friendship.create(user_id: current_user.id , friend_id: params[:id] , aproved: 'yes')
    #pega o ultimo registro de amizade
    @last_friend = Friendship.last
    #seta para MAYBE para que o outro usuario possa aceitar ou nao
    @last_friend.update(aproved: 'maybe')
    redirect_to friends_path
  end

  #solicitações pendentes
  def pending_invitation
    @friends = Friendship.paginate(:page => params[:page], :per_page => 5).where(user_id: current_user).where(aproved: 'maybe')
  end

  #aceitar solicitação
  def aprove_invitation
    @aprovation = Friendship.find(params[:id])
    @aprovation.update(aproved: 'yes')
    redirect_to friends_path
  end

  #recusar  solicitação
  def recuse_invitation
    
    #recusa solicitão
    @recuse_aprovation = Friendship.find(params[:id])
    @recuse_aprovation.update(aproved: 'no')

    #exclui o perfil que recusou da lista de amigos do perfil que solicitou
    #@user_aprovation = Friendship.find(params[:id])
    #@last_aprovation = Friendship.last(2).first
    #@last_aprovation.update(aproved: 'no')

    redirect_to invitations_path 
  end


  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if user_params[:password].blank? 
        @user.update_without_password(user_params_without_password)
        format.html { redirect_to @user, notice: 'User was successfully updated.'  }
        format.json { head :no_content }
      else
        @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.'  }
        format.json { head :no_content }
      end
    end
  end


  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
       params.require(:user).permit(:name, :email, :password, :password_confirmation, :image ,:birth , :genre)
    end

    def user_params_without_password
      user_params.delete(:password)
      user_params.delete(:password_confirmation)
      user_params
    end
end
