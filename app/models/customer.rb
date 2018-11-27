class Customer < ApplicationRecord
  belongs_to :user

  # Instance Method 
  # customer = { first_name "", last_name ""}
  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def self.all_customers(user_id)
    Customer.find_by_sql(["
      SELECT *
      FROM customers AS c
      WHERE c.user_id = ?
      ", user_id])
  end


  def self.single_customer(user_id, customer_id)
    Customer.find_by_sql (["
      SELECT *
      FROM customers AS c
      WHERE c.user_id = ? 
      AND c.id = ?
      ", user_id, customer_id]).first
  end

  def self.create_customer(params, user_id)
    Customer.find_by_sql(["
      INSERT INTO customers (first_name, last_name, email, phone, user_id, created_at, updated_at)
      VALUES (:first, :last, :email, :phone, :user_id, :created_at, :updated_at)
      ", { 
        first: p[:first_name],
        last: p[:last_name],
        email: p[:email],
        phone: p[:phone],
        user_id: user_id,
        created_at :DateTime.now,
        updated_at :DateTime.now
      }])
  end

  def self.delete_customer(customer_id)
    Customer.find_by_sql(["
      DELETE FROM customers AS c
      WHERE c.id = ?
    ;", customer_id])
  end
end
