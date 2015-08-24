set :rails_env, "production"

# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.
#

server '139.162.5.193', user: 'deployer', roles: %w{web app db}
