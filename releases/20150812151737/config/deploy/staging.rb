set :rails_env, "stage"

# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.
#
# role :app, %w{deployer@139.162.29.35}
# role :web, %w{servicer@139.162.29.35}
# role :db,  %w{deployer@139.162.29.35}

server '139.162.29.35', user: 'deployer', roles: %w{web app db}
