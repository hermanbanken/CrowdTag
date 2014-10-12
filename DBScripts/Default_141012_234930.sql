-- Group [Group]
create table `group` (
   `oid`  integer  not null,
   `groupname`  varchar(255),
  primary key (`oid`)
);


-- Module [Module]
create table `module` (
   `oid`  integer  not null,
   `moduleid`  varchar(255),
   `modulename`  varchar(255),
  primary key (`oid`)
);


-- User [User]
create table `user` (
   `oid`  integer  not null,
   `username`  varchar(255),
   `password`  varchar(255),
   `email`  varchar(255),
   `name`  varchar(255),
   `birthdate`  datetime,
  primary key (`oid`)
);


-- Worker [ent1]
create table `worker` (
   `user_oid`  integer  not null,
   `oid`  integer  not null,
   `piggy_bank`  integer,
   `accuracy_count_good`  integer,
   `accuracy_count_all`  integer,
  primary key (`user_oid`)
);


-- Requester [ent2]
create table `requester` (
   `user_oid`  integer  not null,
   `oid`  integer  not null,
  primary key (`user_oid`)
);


-- Campaign [ent3]
create table `campaign` (
   `oid`  integer  not null,
   `name`  varchar(255),
   `budget`  integer,
   `isopen`  bit,
  primary key (`oid`)
);


-- Task [ent4]
create table `task` (
   `oid`  integer  not null,
   `title`  varchar(255),
   `description`  varchar(255),
   `reward`  double precision,
   `maxexectime`  time,
   `exptime`  datetime,
  primary key (`oid`)
);


-- Item [ent5]
create table `item` (
   `oid`  integer  not null,
   `url`  varchar(255),
   `title`  varchar(255),
   `caption`  varchar(255),
  primary key (`oid`)
);


-- Annotation [ent6]
create table `annotation` (
   `oid`  integer  not null,
   `label`  varchar(255),
   `confidence`  integer,
  primary key (`oid`)
);


-- Skill [ent7]
create table `skill` (
   `oid`  integer  not null,
   `name`  varchar(255),
   `description`  varchar(255),
  primary key (`oid`)
);


-- Group_DefaultModule [Group2DefaultModule_DefaultModule2Group]
alter table `group`  add column  `module_oid`  integer;
alter table `group`   add index fk_group_module (`module_oid`), add constraint fk_group_module foreign key (`module_oid`) references `module` (`oid`);


-- Group_Module [Group2Module_Module2Group]
create table `group_module` (
   `group_oid`  integer not null,
   `module_oid`  integer not null,
  primary key (`group_oid`, `module_oid`)
);
alter table `group_module`   add index fk_group_module_group (`group_oid`), add constraint fk_group_module_group foreign key (`group_oid`) references `group` (`oid`);
alter table `group_module`   add index fk_group_module_module (`module_oid`), add constraint fk_group_module_module foreign key (`module_oid`) references `module` (`oid`);


-- User_DefaultGroup [User2DefaultGroup_DefaultGroup2User]
alter table `user`  add column  `group_oid`  integer;
alter table `user`   add index fk_user_group (`group_oid`), add constraint fk_user_group foreign key (`group_oid`) references `group` (`oid`);


-- User_Group [User2Group_Group2User]
create table `user_group` (
   `user_oid`  integer not null,
   `group_oid`  integer not null,
  primary key (`user_oid`, `group_oid`)
);
alter table `user_group`   add index fk_user_group_user (`user_oid`), add constraint fk_user_group_user foreign key (`user_oid`) references `user` (`oid`);
alter table `user_group`   add index fk_user_group_group (`group_oid`), add constraint fk_user_group_group foreign key (`group_oid`) references `group` (`oid`);


-- Requester_Annotation Campaign [rel1]
alter table `requester`  add column  `campaign_oid`  integer;
alter table `requester`   add index fk_requester_campaign (`campaign_oid`), add constraint fk_requester_campaign foreign key (`campaign_oid`) references `campaign` (`oid`);


-- Task_Skill [rel10]
create table `task_skill` (
   `task_oid`  integer not null,
   `skill_oid`  integer not null,
  primary key (`task_oid`, `skill_oid`)
);
alter table `task_skill`   add index fk_task_skill_task (`task_oid`), add constraint fk_task_skill_task foreign key (`task_oid`) references `task` (`oid`);
alter table `task_skill`   add index fk_task_skill_skill (`skill_oid`), add constraint fk_task_skill_skill foreign key (`skill_oid`) references `skill` (`oid`);


-- Annotation_Item [rel2]
alter table `item`  add column  `annotation_oid`  integer;
alter table `item`   add index fk_item_annotation (`annotation_oid`), add constraint fk_item_annotation foreign key (`annotation_oid`) references `annotation` (`oid`);


-- Annotation_Worker [rel3]
alter table `annotation`  add column  `worker_oid`  integer;
alter table `annotation`   add index fk_annotation_worker (`worker_oid`), add constraint fk_annotation_worker foreign key (`worker_oid`) references `worker` (`user_oid`);


-- Item_Task [rel4]
create table `item_task` (
   `item_oid`  integer not null,
   `task_oid`  integer not null,
  primary key (`item_oid`, `task_oid`)
);
alter table `item_task`   add index fk_item_task_item (`item_oid`), add constraint fk_item_task_item foreign key (`item_oid`) references `item` (`oid`);
alter table `item_task`   add index fk_item_task_task (`task_oid`), add constraint fk_item_task_task foreign key (`task_oid`) references `task` (`oid`);


-- Item_Annotation Campaign [rel5]
alter table `campaign`  add column  `item_oid`  integer;
alter table `campaign`   add index fk_campaign_item (`item_oid`), add constraint fk_campaign_item foreign key (`item_oid`) references `item` (`oid`);


-- Task_Annotation Campaign [rel6]
alter table `campaign`  add column  `task_oid`  integer;
alter table `campaign`   add index fk_campaign_task (`task_oid`), add constraint fk_campaign_task foreign key (`task_oid`) references `task` (`oid`);


-- Task_Worker [rel7]
create table `task_worker` (
   `task_oid`  integer not null,
   `worker_oid`  integer not null,
  primary key (`task_oid`, `worker_oid`)
);
alter table `task_worker`   add index fk_task_worker_task (`task_oid`), add constraint fk_task_worker_task foreign key (`task_oid`) references `task` (`oid`);
alter table `task_worker`   add index fk_task_worker_worker (`worker_oid`), add constraint fk_task_worker_worker foreign key (`worker_oid`) references `worker` (`user_oid`);


-- Worker_Skill [rel8]
create table `worker_skill` (
   `worker_oid`  integer not null,
   `skill_oid`  integer not null,
  primary key (`worker_oid`, `skill_oid`)
);
alter table `worker_skill`   add index fk_worker_skill_worker (`worker_oid`), add constraint fk_worker_skill_worker foreign key (`worker_oid`) references `worker` (`user_oid`);
alter table `worker_skill`   add index fk_worker_skill_skill (`skill_oid`), add constraint fk_worker_skill_skill foreign key (`skill_oid`) references `skill` (`oid`);


-- GEN FK: Worker --> User
alter table `worker`   add index fk_worker_user (`user_oid`), add constraint fk_worker_user foreign key (`user_oid`) references `user` (`oid`);


-- GEN FK: Requester --> User
alter table `requester`   add index fk_requester_user (`user_oid`), add constraint fk_requester_user foreign key (`user_oid`) references `user` (`oid`);


