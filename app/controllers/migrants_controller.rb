class MigrantsController < ApplicationController
  def index
    @pagy, @migrants = pagy(policy_scope(authorize Migrant.all))
  end
end
