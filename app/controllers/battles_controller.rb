class BattlesController < ApplicationController
  before_action :find_battle, only: [:show, :edit, :update, :team_fight, :destroy]

  def show
    @team1 = @battle.team1
    @team2 = @battle.team2
    @battle.name = "#{@team1.roster_name} vs. #{@team2.roster_name}"

  end

  def team_fight
    @battle_array = @battle.winner[1]
    @result = @battle.winner[0]
    flash[:duels] = []
    flash[:winner] = @result
    @battle_array.each {|duel| flash[:duels] << duel}
    redirect_to @battle
  end

  def index
    @battles = Battle.all
  end

  def new
    @battle = Battle.new
    @teams = Team.all
  end

  # TODO move to application controller for session stuff

  def create
    @battle = Battle.create(battle_params)
    t1 = @battle.team1
    t2 = @battle.team2
    @battle.name = "#{t1.roster_name} vs. #{t2.roster_name}"
    @battle.save
    redirect_to @battle
  end

  private

  def find_battle
    @battle = Battle.find_by(id: params[:id])
  end

  def battle_params
    params.require(:battle).permit(:team_id1, :team_id2, :name)
  end

end
