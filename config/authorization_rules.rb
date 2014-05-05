authorization do
  role :developer do
    has_permission_on [:users], to: [:read, :update, :impersonate]
    includes :admin
  end


  role :admin do
    has_permission_on :events, to: :administrate
  end
end

privileges do
  privilege :create, includes: :new
  privilege :read, includes: [:index, :show]
  privilege :update, includes: :edit
  privilege :delete, includes: :destroy
  privilege :administrate, includes: [:create, :read, :update, :delete]
end