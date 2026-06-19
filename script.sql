create table assigment1.customers (
	id int,
	name varchar(100),
	email varchar(100),
	city varchar(50)
);

create table assigment1.orders (
	id int,
	customer_id int,
	order_date timestamp,
	status varchar(50)
);

create table assigment1.order_items (
	id int,
	order_id int,
	product_id int,
	quantity int,
	sale_price int
);

create table assigment1.categories (
	id int,
	name varchar(100)
);

create table assigment1.products (
	id int,
	name varchar(100),
	category_id int,
	price int
);


-- шукаємо топ-3 покупців з Києва, які залишили найбільше грошей у категорії "смартфони", та топ-3 покупців з Києва, які витратили найбільше у категорії "ноутбуки"


with top_smartphones as (
	select
		c.id as customer_id,
		c."name" as customer_name,
		c.email as customer_email,
		c.city as customer_city,
		c2."name",
		sum(oi.quantity * oi.sale_price) as money_spent
	from assigment1.customers c 
	join assigment1.orders o 
	on c.id = o.customer_id
	join assigment1.order_items oi 
	on o.id = oi.order_id 
	join assigment1.products p 
	on oi.product_id = p.id 
	join assigment1.categories c2 
	on p.category_id = c2.id 
	
	where c.city = 'Київ'
		and c2.name = 'Смартфони'
		
	group by c.id, c."name", c.email, c.city, c2."name"
	
	order by money_spent desc
	
	limit 3
),
top_laptops as (
	select
		c.id as customer_id,
		c."name" as customer_name,
		c.email as customer_email,
		c.city as customer_city,
		c2."name",
		sum(oi.quantity * oi.sale_price) as money_spent
	from assigment1.customers c 
	join assigment1.orders o 
	on c.id = o.customer_id
	join assigment1.order_items oi 
	on o.id = oi.order_id 
	join assigment1.products p 
	on oi.product_id = p.id 
	join assigment1.categories c2 
	on p.category_id = c2.id 
	
	where c.city = 'Київ'
		and c2.name = 'Ноутбуки'
		
	group by c.id, c."name", c.email, c.city, c2."name"
	
	order by money_spent desc
	
	limit 3
)

select * from top_smartphones
union all
select * from top_laptops;
