class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:

      user ||= Agency.new # guest user (not logged in)
      if user.is_a? Agency
        can :manage, Property, agency: {agency_id: user.id}
        # can :manage, Agency, {agency_id: user.id}
      end
      if user.is_a? Tenant
        can :show, Property, agency: {agency_id: user.id}
        # can :manage, Agency, {agency_id: user.id}

      end


      
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
