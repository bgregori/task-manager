create table hibernate_sequence (next_val bigint);
insert into hibernate_sequence values ( 1 );
create table Task (id bigint not null, completed bit not null default 0, task_text varchar(255), title varchar(255), primary key (id));