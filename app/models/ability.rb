class Ability
  include CanCan::Ability

  def initialize(user)
    # rubocop:disable Lint/UselessAssignment
    user ||= User.new

    can :manage, :all
  end
end
