admin = Admin.create(username: 'admin', password: 'adminadmin', :password_confirmation => 'adminadmin', :email => 'admin@owl.com')

role = Role.create(name: 'admin', title: 'Admin')
admin.roles << role

Permission.create([
  { action: 'manage', subject: 'user', description: 'User Management' },
  { action: 'manage', subject: 'admin', description: 'Admin Management' }
])

Role.create(name: 'teacher', title: 'Teacher')
