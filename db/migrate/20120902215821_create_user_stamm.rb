class CreateUserStamm < ActiveRecord::Migration
  def up
    execute "INSERT INTO `users` (`name`, `password_digest`, `created_at`, `updated_at`)
VALUES
	('stamm', '$2a$10$1r.etpQZI/dhOoMVfogYNOoq3IM3l9B0qvXf7n16PJwrL26OkyjK2', '2012-09-02 21:56:36', '2012-09-02 21:56:36');"
  end

  def down
    execute "DELETE FROM users WHERE name = 'stamm'"
  end
end
