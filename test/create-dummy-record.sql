/* Declare vars */
\set address_id int;
\set profile_id int;
\set active_id int;
\set login_id int;



\connect frentzydb

/* If Province table already has items, delete all rows and reset sequence */

delete from public."Province";
ALTER SEQUENCE public."Province_id_seq" RESTART WITH 1;


/* Insert records into Province */
insert into public."Province" (province) values ('alberta'),
('british columbia'),
('saskatchewan'),
('manitoba'),
('ontario'),
('quebec'),
('newfoundland and labrador'),
('new brunswick'),
('prince edward island'),
('nova scotia'),
('yukon'),
('northwestern territories'),
('nunavut');

insert into public."Address" (address1,addres2,city,provinceid,postalcode) 
	values ('507 89 St SW',Null,'Edmonton',(select id from public."Province" where province='alberta'),'t6x1c9') 
	returning id;

/*select * from id_tbl;
	
	insert into public."UserProfile" (description,profilepic) 
	values (Null,Null) 
	returning id)
	insert into id_tbl;
	
	insert into public."UserActive" (islocked) values (False) returning id insert into active_id;
	insert into public."Login" (password) values ('plaintxt') returning id insert into login_id;
*/

/*
insert into public."User" (addressid,email,firstname,lastname,verified,lastactive,createdate,profileid,loginid,activeid)
values ((select id from public."Address" where id=address_id),'test@test.com','joe','blow',default,default,default,(select id from public."UserProfile" where id=profile_id),(select id from public."Login" where id=login_id),(select id from public."UserActive" where id=active_id));
*/



