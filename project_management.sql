-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 06, 2025 at 08:52 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `project_management`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin_app_project`
--

CREATE TABLE `admin_app_project` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `short_code` varchar(20) NOT NULL,
  `description` longtext NOT NULL,
  `client` varchar(100) NOT NULL,
  `category` varchar(50) NOT NULL,
  `files` varchar(100) DEFAULT NULL,
  `budget` varchar(100) NOT NULL,
  `start_date` date NOT NULL,
  `due_date` date DEFAULT NULL,
  `progress` double NOT NULL,
  `status` varchar(20) NOT NULL,
  `priority` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin_app_project`
--

INSERT INTO `admin_app_project` (`id`, `name`, `short_code`, `description`, `client`, `category`, `files`, `budget`, `start_date`, `due_date`, `progress`, `status`, `priority`) VALUES
(1, 'project 1', 'p1', 'asdfghjkl;lktyuiofgyujn', 'teche.pvt.ltd', 'Mobile App', 'files/1703134846_Mpj6wox.pdf', '35000', '2025-01-23', '2025-02-13', 0, 'Pending', 'Medium'),
(2, 'project 2', 'p2', 'gfdcghbjnm,gfdmnnbgvghhghbbb', 'Codex pvt.ltd', 'Data Analysis', 'files/1703134846_590cnW3.pdf', '40000', '2025-01-28', NULL, 0, 'Pending', 'Low'),
(3, 'project 3', 'p3', 'xdtfyguijo', 'toolprinttech', 'Web Development', 'files/2c0a0e80-1823-11ea-9d35-91091ed13a2f.jpg', '40000', '2025-01-31', NULL, 0, 'Pending', 'Low');

-- --------------------------------------------------------

--
-- Table structure for table `admin_app_project_assigned`
--

CREATE TABLE `admin_app_project_assigned` (
  `id` bigint(20) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  `user_id` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin_app_project_assigned`
--

INSERT INTO `admin_app_project_assigned` (`id`, `project_id`, `user_id`) VALUES
(4, 1, '1174'),
(1, 1, '1178'),
(5, 2, '1174'),
(8, 2, '1178'),
(7, 2, '1180'),
(11, 3, '1112'),
(10, 3, '1174');

-- --------------------------------------------------------

--
-- Table structure for table `admin_app_sprint`
--

CREATE TABLE `admin_app_sprint` (
  `id` bigint(20) NOT NULL,
  `sprint_name` varchar(100) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `description` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin_app_sprint`
--

INSERT INTO `admin_app_sprint` (`id`, `sprint_name`, `start_date`, `end_date`, `description`) VALUES
(1, 'erp', '2025-01-22', '2025-01-28', 'testing'),
(2, 'HHP-SPC', '2025-02-01', '2025-02-28', 'feb high and low'),
(3, 'ASM-IP', '2025-03-01', '2025-03-31', 'march pending workes'),
(4, 'NW- AUT', '2025-03-01', '2025-03-31', '0yfxdfghjkkgfg'),
(5, 'FEB- test', '2025-02-01', '2025-02-28', 'asdftgyh');

-- --------------------------------------------------------

--
-- Table structure for table `admin_app_sprint_completed_tasks`
--

CREATE TABLE `admin_app_sprint_completed_tasks` (
  `id` bigint(20) NOT NULL,
  `sprint_id` bigint(20) NOT NULL,
  `task_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `admin_app_sprint_in_progress_tasks`
--

CREATE TABLE `admin_app_sprint_in_progress_tasks` (
  `id` bigint(20) NOT NULL,
  `sprint_id` bigint(20) NOT NULL,
  `task_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `admin_app_sprint_pending_tasks`
--

CREATE TABLE `admin_app_sprint_pending_tasks` (
  `id` bigint(20) NOT NULL,
  `sprint_id` bigint(20) NOT NULL,
  `task_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin_app_sprint_pending_tasks`
--

INSERT INTO `admin_app_sprint_pending_tasks` (`id`, `sprint_id`, `task_id`) VALUES
(5, 1, 15),
(10, 1, 21),
(3, 2, 12),
(8, 2, 19),
(6, 3, 17),
(4, 4, 16),
(7, 4, 18),
(9, 4, 20),
(11, 5, 22),
(12, 5, 23);

-- --------------------------------------------------------

--
-- Table structure for table `admin_app_sprint_tasks`
--

CREATE TABLE `admin_app_sprint_tasks` (
  `id` bigint(20) NOT NULL,
  `sprint_id` bigint(20) NOT NULL,
  `task_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin_app_sprint_tasks`
--

INSERT INTO `admin_app_sprint_tasks` (`id`, `sprint_id`, `task_id`) VALUES
(10, 1, 15),
(15, 1, 21),
(5, 2, 12),
(13, 2, 19),
(11, 3, 17),
(9, 4, 16),
(12, 4, 18),
(14, 4, 20),
(16, 5, 22),
(17, 5, 23);

-- --------------------------------------------------------

--
-- Table structure for table `admin_app_task`
--

CREATE TABLE `admin_app_task` (
  `id` bigint(20) NOT NULL,
  `task_name` varchar(100) NOT NULL,
  `description` longtext NOT NULL,
  `category` varchar(50) NOT NULL,
  `priority` varchar(20) NOT NULL,
  `status` varchar(50) NOT NULL,
  `start_date` date NOT NULL,
  `due_date` date DEFAULT NULL,
  `estimated_hours` int(10) UNSIGNED NOT NULL CHECK (`estimated_hours` >= 0),
  `project_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin_app_task`
--

INSERT INTO `admin_app_task` (`id`, `task_name`, `description`, `category`, `priority`, `status`, `start_date`, `due_date`, `estimated_hours`, `project_id`) VALUES
(5, 'bug the code and ensure the connection with db', 'sdftghjk', 'Bug', 'High', 'Completed', '2025-01-24', '2025-01-28', 16, 1),
(6, 'ui ux designing to develop front page of the web application', 'ertfgyhj', 'UI design', 'Medium', 'In Progress', '2025-01-25', '2025-01-28', 16, 1),
(12, 'graphic designing', 'dddcvvbbnnnnmkl...jnuuuuuuuuuuuuiiiiiiii888vfffcvbcvx  vbhv bgbaAAA', 'UI design', 'High', 'Pending', '2025-01-22', '2025-01-28', 18, 2),
(15, 'hospital management template', 'wdfdcs', 'Front end', 'High', 'Pending', '2025-01-28', '2025-02-01', 19, 2),
(16, 'analysing the quality of testing and implementation', 'sdfghuiop', 'Testing', 'Low', 'Completed', '2025-01-31', '2025-02-04', 16, 3),
(17, 'database connections and migration', 'sdcvbhjkl;', 'Database', 'Medium', 'Pending', '2025-02-03', '2025-02-11', 16, 3),
(18, 'front end developing', 'sdfghjkl', 'Front end', 'High', 'Completed', '2025-02-04', '2025-02-11', 9, 3),
(19, 'designing the template', 'dfghjkl', 'Front end', 'Medium', 'Completed', '2025-02-03', '2025-02-11', 19, 3),
(20, 'designing the template', 'sdfghjk', 'UI design', 'Medium', 'Completed', '2025-02-03', NULL, 19, 3),
(21, 'ux design', 'asddsd', 'UI design', 'High', 'Pending', '2025-02-03', '2025-02-11', 16, 1),
(22, 'checking the bug and fix the testing process', 'sadfg', 'Bug', 'High', 'Completed', '2025-02-04', '2025-02-05', 1, 3),
(23, 'create the backend and create migrations', 'aqsdfghuj', 'Database', 'Low', 'In Progress', '2025-02-04', '2025-02-07', 3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `admin_app_taskprogress`
--

CREATE TABLE `admin_app_taskprogress` (
  `id` bigint(20) NOT NULL,
  `start_time` datetime(6) NOT NULL,
  `end_time` datetime(6) DEFAULT NULL,
  `task_id` bigint(20) NOT NULL,
  `user_id` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `admin_app_task_assigned_to`
--

CREATE TABLE `admin_app_task_assigned_to` (
  `id` bigint(20) NOT NULL,
  `task_id` bigint(20) NOT NULL,
  `user_id` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin_app_task_assigned_to`
--

INSERT INTO `admin_app_task_assigned_to` (`id`, `task_id`, `user_id`) VALUES
(6, 5, '1174'),
(7, 6, '1178'),
(13, 12, '1174'),
(16, 15, '1180'),
(17, 16, '1112'),
(18, 17, '1174'),
(19, 18, '1112'),
(20, 19, '1112'),
(21, 20, '1112'),
(22, 21, '1174'),
(23, 22, '1112'),
(24, 23, '1112');

-- --------------------------------------------------------

--
-- Table structure for table `admin_app_user`
--

CREATE TABLE `admin_app_user` (
  `reg_no` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `designation` varchar(100) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `phone` varchar(15) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin_app_user`
--

INSERT INTO `admin_app_user` (`reg_no`, `name`, `designation`, `image`, `phone`, `email`, `password`, `role`) VALUES
('1112', 'Zoya', 'softwear tester', 'images/emp_1_805k539.jpg', '7638986567', 'zoya@gmail.com', 'pbkdf2_sha256$600000$LsPFDtaXIwKMPCV3EOadoI$IGhNln2ubUthfWOw1dxPlVXl3SDOzFdgv1P2hF8fp3s=', 'employee'),
('1164', 'leon mask', 'Backend developer', 'images/emp_3_xFQvi4L.jpg', '07654456789', 'leon@gmail.com', '6', 'employee'),
('1174', 'Sara abraham', 'Graphic designer', 'images/emp_4_qnYao5E.jpg', '03452345678', 'sara@gmail.com', '6', 'employee'),
('1178', 'leo', 'softwear tester', 'images/emp_1_kBr8H3d.jpg', '7656789098', 'leo@gmail.com', '6', 'employee'),
('1180', 'Frank', 'ux designer', 'images/emp_5.jpg', '09755367898', 'frank@gmail.com', '6', 'employee');

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add permission', 1, 'add_permission'),
(2, 'Can change permission', 1, 'change_permission'),
(3, 'Can delete permission', 1, 'delete_permission'),
(4, 'Can view permission', 1, 'view_permission'),
(5, 'Can add group', 2, 'add_group'),
(6, 'Can change group', 2, 'change_group'),
(7, 'Can delete group', 2, 'delete_group'),
(8, 'Can view group', 2, 'view_group'),
(9, 'Can add user', 3, 'add_user'),
(10, 'Can change user', 3, 'change_user'),
(11, 'Can delete user', 3, 'delete_user'),
(12, 'Can view user', 3, 'view_user'),
(13, 'Can add content type', 4, 'add_contenttype'),
(14, 'Can change content type', 4, 'change_contenttype'),
(15, 'Can delete content type', 4, 'delete_contenttype'),
(16, 'Can view content type', 4, 'view_contenttype'),
(17, 'Can add project', 5, 'add_project'),
(18, 'Can change project', 5, 'change_project'),
(19, 'Can delete project', 5, 'delete_project'),
(20, 'Can view project', 5, 'view_project'),
(21, 'Can add sprint', 6, 'add_sprint'),
(22, 'Can change sprint', 6, 'change_sprint'),
(23, 'Can delete sprint', 6, 'delete_sprint'),
(24, 'Can view sprint', 6, 'view_sprint'),
(25, 'Can add task', 7, 'add_task'),
(26, 'Can change task', 7, 'change_task'),
(27, 'Can delete task', 7, 'delete_task'),
(28, 'Can view task', 7, 'view_task'),
(29, 'Can add user', 8, 'add_user'),
(30, 'Can change user', 8, 'change_user'),
(31, 'Can delete user', 8, 'delete_user'),
(32, 'Can view user', 8, 'view_user'),
(33, 'Can add taskprogress', 9, 'add_taskprogress'),
(34, 'Can change taskprogress', 9, 'change_taskprogress'),
(35, 'Can delete taskprogress', 9, 'delete_taskprogress'),
(36, 'Can view taskprogress', 9, 'view_taskprogress'),
(37, 'Can add comment', 10, 'add_comment'),
(38, 'Can change comment', 10, 'change_comment'),
(39, 'Can delete comment', 10, 'delete_comment'),
(40, 'Can view comment', 10, 'view_comment'),
(41, 'Can add log entry', 11, 'add_logentry'),
(42, 'Can change log entry', 11, 'change_logentry'),
(43, 'Can delete log entry', 11, 'delete_logentry'),
(44, 'Can view log entry', 11, 'view_logentry'),
(45, 'Can add session', 12, 'add_session'),
(46, 'Can change session', 12, 'change_session'),
(47, 'Can delete session', 12, 'delete_session'),
(48, 'Can view session', 12, 'view_session'),
(49, 'Can add task time', 13, 'add_tasktime'),
(50, 'Can change task time', 13, 'change_tasktime'),
(51, 'Can delete task time', 13, 'delete_tasktime'),
(52, 'Can view task time', 13, 'view_tasktime'),
(53, 'Can add comment', 14, 'add_comment'),
(54, 'Can change comment', 14, 'change_comment'),
(55, 'Can delete comment', 14, 'delete_comment'),
(56, 'Can view comment', 14, 'view_comment');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(11, 'admin', 'logentry'),
(10, 'admin_app', 'comment'),
(5, 'admin_app', 'project'),
(6, 'admin_app', 'sprint'),
(7, 'admin_app', 'task'),
(9, 'admin_app', 'taskprogress'),
(8, 'admin_app', 'user'),
(2, 'auth', 'group'),
(1, 'auth', 'permission'),
(3, 'auth', 'user'),
(4, 'contenttypes', 'contenttype'),
(14, 'employee_app', 'comment'),
(13, 'employee_app', 'tasktime'),
(12, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2025-01-21 14:04:14.796827'),
(2, 'auth', '0001_initial', '2025-01-21 14:04:15.921828'),
(3, 'admin_app', '0001_initial', '2025-01-21 14:04:17.374953'),
(4, 'admin_app', '0002_remove_task_sprint', '2025-01-23 05:18:50.600885'),
(5, 'admin_app', '0003_sprint_tasks', '2025-01-23 05:40:02.162949'),
(6, 'admin_app', '0004_sprint_is_active', '2025-01-23 05:46:01.558060'),
(7, 'admin_app', '0005_remove_sprint_is_active', '2025-01-23 05:47:28.085054'),
(8, 'admin_app', '0006_alter_task_status', '2025-01-24 07:54:03.914351'),
(9, 'admin_app', '0007_sprint_completed_tasks_sprint_in_progress_tasks_and_more', '2025-01-25 15:30:42.856283'),
(10, 'admin', '0001_initial', '2025-01-27 06:58:41.115719'),
(11, 'admin', '0002_logentry_remove_auto_add', '2025-01-27 06:58:41.162598'),
(12, 'admin', '0003_logentry_add_action_flag_choices', '2025-01-27 06:58:41.193847'),
(13, 'contenttypes', '0002_remove_content_type_name', '2025-01-27 06:58:41.396969'),
(14, 'auth', '0002_alter_permission_name_max_length', '2025-01-27 06:58:41.600095'),
(15, 'auth', '0003_alter_user_email_max_length', '2025-01-27 06:58:41.662595'),
(16, 'auth', '0004_alter_user_username_opts', '2025-01-27 06:58:41.693844'),
(17, 'auth', '0005_alter_user_last_login_null', '2025-01-27 06:58:41.881346'),
(18, 'auth', '0006_require_contenttypes_0002', '2025-01-27 06:58:41.896990'),
(19, 'auth', '0007_alter_validators_add_error_messages', '2025-01-27 06:58:41.912609'),
(20, 'auth', '0008_alter_user_username_max_length', '2025-01-27 06:58:41.959469'),
(21, 'auth', '0009_alter_user_last_name_max_length', '2025-01-27 06:58:42.006361'),
(22, 'auth', '0010_alter_group_name_max_length', '2025-01-27 06:58:42.084489'),
(23, 'auth', '0011_update_proxy_permissions', '2025-01-27 06:58:42.115741'),
(24, 'auth', '0012_alter_user_first_name_max_length', '2025-01-27 06:58:42.146971'),
(25, 'sessions', '0001_initial', '2025-01-27 06:58:42.240739'),
(26, 'employee_app', '0001_initial', '2025-01-27 07:36:14.231506'),
(27, 'employee_app', '0002_alter_tasktime_options', '2025-01-28 05:08:43.645695'),
(28, 'employee_app', '0003_alter_tasktime_options', '2025-01-28 05:37:07.860939'),
(29, 'employee_app', '0004_alter_tasktime_task', '2025-01-28 06:09:17.445668'),
(30, 'employee_app', '0005_tasktime_total_time', '2025-01-30 07:47:53.806239'),
(31, 'employee_app', '0006_remove_tasktime_total_time', '2025-01-30 07:47:53.868723'),
(32, 'admin_app', '0008_user_password', '2025-01-30 08:43:19.718219'),
(33, 'admin_app', '0009_user_role_alter_comment_user', '2025-01-31 07:02:08.111838'),
(34, 'admin_app', '0010_delete_comment', '2025-02-03 08:38:56.353610'),
(35, 'employee_app', '0007_comment', '2025-02-03 08:46:06.909946'),
(36, 'employee_app', '0008_tasktime_completed_time', '2025-02-04 15:42:17.952907'),
(37, 'employee_app', '0009_tasktime_total_duration', '2025-02-05 10:04:06.905531'),
(38, 'employee_app', '0010_remove_tasktime_total_duration', '2025-02-05 11:25:51.676624');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('q7o62g2dne1n9m40t3ou39h4dq8ya84f', 'eyJ1c2VyX3JlZ19ubyI6IjExMTIifQ:1tfwGq:CkK7r1OdNMpBlVWOIGo1LQoamG-FXlCCYVcCUGNfMNE', '2025-02-20 07:25:56.557251');

-- --------------------------------------------------------

--
-- Table structure for table `employee_app_comment`
--

CREATE TABLE `employee_app_comment` (
  `id` bigint(20) NOT NULL,
  `content` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  `user_id` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_app_tasktime`
--

CREATE TABLE `employee_app_tasktime` (
  `id` bigint(20) NOT NULL,
  `start_time` datetime(6) DEFAULT NULL,
  `stop_time` datetime(6) DEFAULT NULL,
  `task_id` bigint(20) NOT NULL,
  `completed_time` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee_app_tasktime`
--

INSERT INTO `employee_app_tasktime` (`id`, `start_time`, `stop_time`, `task_id`, `completed_time`) VALUES
(1, '2025-01-28 05:58:51.379904', '2025-01-28 05:58:51.379904', 5, NULL),
(4, '2025-01-28 06:35:58.552000', '2025-01-28 06:37:09.311000', 6, NULL),
(5, '2025-01-28 06:49:48.313000', '2025-01-28 06:53:27.933000', 5, NULL),
(7, '2025-01-30 07:49:15.115000', '2025-01-30 07:49:25.717000', 5, NULL),
(8, '2025-01-30 07:49:45.011000', '2025-01-30 07:50:47.181000', 5, NULL),
(9, '2025-01-31 08:20:09.921000', '2025-01-31 08:21:12.049000', 16, NULL),
(10, '2025-01-31 08:49:42.245000', '2025-01-31 08:54:05.809000', 16, NULL),
(12, '2025-02-03 07:55:57.864000', '2025-02-03 07:56:59.951000', 16, NULL),
(13, '2025-02-03 09:52:20.184000', '2025-02-03 09:52:39.628000', 16, NULL),
(14, '2025-02-03 10:19:36.731000', '2025-02-03 10:20:59.314000', 18, NULL),
(15, NULL, '2025-02-04 15:54:06.948278', 19, NULL),
(16, '2025-02-04 15:49:13.117000', '2025-02-04 15:54:05.041000', 19, NULL),
(17, '2025-02-05 09:31:34.139000', '2025-02-05 09:32:42.188000', 20, NULL),
(18, '2025-02-05 09:45:55.121000', '2025-02-05 09:47:09.650000', 20, NULL),
(19, '2025-02-05 10:13:54.662434', NULL, 20, NULL),
(20, '2025-02-05 10:21:59.862625', NULL, 20, NULL),
(21, '2025-02-05 10:34:28.302393', NULL, 20, NULL),
(22, '2025-02-05 11:18:06.112527', NULL, 20, NULL),
(23, '2025-02-05 11:24:20.345059', NULL, 20, NULL),
(24, '2025-02-05 11:27:15.567000', '2025-02-05 11:28:16.926000', 20, NULL),
(25, '2025-02-05 11:32:35.154000', '2025-02-05 11:33:39.011000', 20, NULL),
(26, NULL, '2025-02-05 12:11:48.513086', 19, NULL),
(27, NULL, '2025-02-05 12:12:06.950396', 20, NULL),
(28, '2025-02-06 05:36:41.163000', '2025-02-06 05:36:53.064000', 16, NULL),
(29, NULL, '2025-02-06 05:37:01.623181', 19, NULL),
(30, NULL, '2025-02-06 05:37:56.391264', 18, NULL),
(31, NULL, '2025-02-06 05:39:09.711471', 16, NULL),
(32, '2025-02-06 07:32:49.489000', '2025-02-06 07:34:01.215000', 22, NULL),
(33, '2025-02-06 07:48:09.600000', '2025-02-06 07:48:38.195000', 23, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_app_project`
--
ALTER TABLE `admin_app_project`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `short_code` (`short_code`);

--
-- Indexes for table `admin_app_project_assigned`
--
ALTER TABLE `admin_app_project_assigned`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admin_app_project_assigned_project_id_user_id_3f454891_uniq` (`project_id`,`user_id`),
  ADD KEY `admin_app_project_as_user_id_69f80cff_fk_admin_app` (`user_id`);

--
-- Indexes for table `admin_app_sprint`
--
ALTER TABLE `admin_app_sprint`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admin_app_sprint_completed_tasks`
--
ALTER TABLE `admin_app_sprint_completed_tasks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admin_app_sprint_completed_tasks_sprint_id_task_id_2d3c3737_uniq` (`sprint_id`,`task_id`),
  ADD KEY `admin_app_sprint_com_task_id_9a7b6b20_fk_admin_app` (`task_id`);

--
-- Indexes for table `admin_app_sprint_in_progress_tasks`
--
ALTER TABLE `admin_app_sprint_in_progress_tasks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admin_app_sprint_in_prog_sprint_id_task_id_52d661b8_uniq` (`sprint_id`,`task_id`),
  ADD KEY `admin_app_sprint_in__task_id_653c6a7a_fk_admin_app` (`task_id`);

--
-- Indexes for table `admin_app_sprint_pending_tasks`
--
ALTER TABLE `admin_app_sprint_pending_tasks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admin_app_sprint_pending_tasks_sprint_id_task_id_cf0e8f05_uniq` (`sprint_id`,`task_id`),
  ADD KEY `admin_app_sprint_pen_task_id_438731b8_fk_admin_app` (`task_id`);

--
-- Indexes for table `admin_app_sprint_tasks`
--
ALTER TABLE `admin_app_sprint_tasks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admin_app_sprint_tasks_sprint_id_task_id_ceb1c599_uniq` (`sprint_id`,`task_id`),
  ADD KEY `admin_app_sprint_tasks_task_id_0753eb85_fk_admin_app_task_id` (`task_id`);

--
-- Indexes for table `admin_app_task`
--
ALTER TABLE `admin_app_task`
  ADD PRIMARY KEY (`id`),
  ADD KEY `admin_app_task_project_id_23e787f3_fk_admin_app_project_id` (`project_id`);

--
-- Indexes for table `admin_app_taskprogress`
--
ALTER TABLE `admin_app_taskprogress`
  ADD PRIMARY KEY (`id`),
  ADD KEY `admin_app_taskprogress_task_id_c603e152_fk_admin_app_task_id` (`task_id`),
  ADD KEY `admin_app_taskprogress_user_id_e049e2d3_fk_admin_app_user_reg_no` (`user_id`);

--
-- Indexes for table `admin_app_task_assigned_to`
--
ALTER TABLE `admin_app_task_assigned_to`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admin_app_task_assigned_to_task_id_user_id_4994c8a8_uniq` (`task_id`,`user_id`),
  ADD KEY `admin_app_task_assig_user_id_b99a23fe_fk_admin_app` (`user_id`);

--
-- Indexes for table `admin_app_user`
--
ALTER TABLE `admin_app_user`
  ADD PRIMARY KEY (`reg_no`);

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `employee_app_comment`
--
ALTER TABLE `employee_app_comment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_app_comment_project_id_bd5e8399_fk_admin_app_project_id` (`project_id`),
  ADD KEY `employee_app_comment_user_id_e35b83c6_fk_admin_app_user_reg_no` (`user_id`);

--
-- Indexes for table `employee_app_tasktime`
--
ALTER TABLE `employee_app_tasktime`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_app_tasktime_task_id_d13171a8_fk_admin_app_task_id` (`task_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_app_project`
--
ALTER TABLE `admin_app_project`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `admin_app_project_assigned`
--
ALTER TABLE `admin_app_project_assigned`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `admin_app_sprint`
--
ALTER TABLE `admin_app_sprint`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `admin_app_sprint_completed_tasks`
--
ALTER TABLE `admin_app_sprint_completed_tasks`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admin_app_sprint_in_progress_tasks`
--
ALTER TABLE `admin_app_sprint_in_progress_tasks`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admin_app_sprint_pending_tasks`
--
ALTER TABLE `admin_app_sprint_pending_tasks`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `admin_app_sprint_tasks`
--
ALTER TABLE `admin_app_sprint_tasks`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `admin_app_task`
--
ALTER TABLE `admin_app_task`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `admin_app_taskprogress`
--
ALTER TABLE `admin_app_taskprogress`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admin_app_task_assigned_to`
--
ALTER TABLE `admin_app_task_assigned_to`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `employee_app_comment`
--
ALTER TABLE `employee_app_comment`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employee_app_tasktime`
--
ALTER TABLE `employee_app_tasktime`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin_app_project_assigned`
--
ALTER TABLE `admin_app_project_assigned`
  ADD CONSTRAINT `admin_app_project_as_project_id_f7bbe30c_fk_admin_app` FOREIGN KEY (`project_id`) REFERENCES `admin_app_project` (`id`),
  ADD CONSTRAINT `admin_app_project_as_user_id_69f80cff_fk_admin_app` FOREIGN KEY (`user_id`) REFERENCES `admin_app_user` (`reg_no`);

--
-- Constraints for table `admin_app_sprint_completed_tasks`
--
ALTER TABLE `admin_app_sprint_completed_tasks`
  ADD CONSTRAINT `admin_app_sprint_com_sprint_id_408f99d0_fk_admin_app` FOREIGN KEY (`sprint_id`) REFERENCES `admin_app_sprint` (`id`),
  ADD CONSTRAINT `admin_app_sprint_com_task_id_9a7b6b20_fk_admin_app` FOREIGN KEY (`task_id`) REFERENCES `admin_app_task` (`id`);

--
-- Constraints for table `admin_app_sprint_in_progress_tasks`
--
ALTER TABLE `admin_app_sprint_in_progress_tasks`
  ADD CONSTRAINT `admin_app_sprint_in__sprint_id_4eb3d2d0_fk_admin_app` FOREIGN KEY (`sprint_id`) REFERENCES `admin_app_sprint` (`id`),
  ADD CONSTRAINT `admin_app_sprint_in__task_id_653c6a7a_fk_admin_app` FOREIGN KEY (`task_id`) REFERENCES `admin_app_task` (`id`);

--
-- Constraints for table `admin_app_sprint_pending_tasks`
--
ALTER TABLE `admin_app_sprint_pending_tasks`
  ADD CONSTRAINT `admin_app_sprint_pen_sprint_id_4564c70c_fk_admin_app` FOREIGN KEY (`sprint_id`) REFERENCES `admin_app_sprint` (`id`),
  ADD CONSTRAINT `admin_app_sprint_pen_task_id_438731b8_fk_admin_app` FOREIGN KEY (`task_id`) REFERENCES `admin_app_task` (`id`);

--
-- Constraints for table `admin_app_sprint_tasks`
--
ALTER TABLE `admin_app_sprint_tasks`
  ADD CONSTRAINT `admin_app_sprint_tasks_sprint_id_6c959afb_fk_admin_app_sprint_id` FOREIGN KEY (`sprint_id`) REFERENCES `admin_app_sprint` (`id`),
  ADD CONSTRAINT `admin_app_sprint_tasks_task_id_0753eb85_fk_admin_app_task_id` FOREIGN KEY (`task_id`) REFERENCES `admin_app_task` (`id`);

--
-- Constraints for table `admin_app_task`
--
ALTER TABLE `admin_app_task`
  ADD CONSTRAINT `admin_app_task_project_id_23e787f3_fk_admin_app_project_id` FOREIGN KEY (`project_id`) REFERENCES `admin_app_project` (`id`);

--
-- Constraints for table `admin_app_taskprogress`
--
ALTER TABLE `admin_app_taskprogress`
  ADD CONSTRAINT `admin_app_taskprogress_task_id_c603e152_fk_admin_app_task_id` FOREIGN KEY (`task_id`) REFERENCES `admin_app_task` (`id`),
  ADD CONSTRAINT `admin_app_taskprogress_user_id_e049e2d3_fk_admin_app_user_reg_no` FOREIGN KEY (`user_id`) REFERENCES `admin_app_user` (`reg_no`);

--
-- Constraints for table `admin_app_task_assigned_to`
--
ALTER TABLE `admin_app_task_assigned_to`
  ADD CONSTRAINT `admin_app_task_assig_user_id_b99a23fe_fk_admin_app` FOREIGN KEY (`user_id`) REFERENCES `admin_app_user` (`reg_no`),
  ADD CONSTRAINT `admin_app_task_assigned_to_task_id_8078033a_fk_admin_app_task_id` FOREIGN KEY (`task_id`) REFERENCES `admin_app_task` (`id`);

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `employee_app_comment`
--
ALTER TABLE `employee_app_comment`
  ADD CONSTRAINT `employee_app_comment_project_id_bd5e8399_fk_admin_app_project_id` FOREIGN KEY (`project_id`) REFERENCES `admin_app_project` (`id`),
  ADD CONSTRAINT `employee_app_comment_user_id_e35b83c6_fk_admin_app_user_reg_no` FOREIGN KEY (`user_id`) REFERENCES `admin_app_user` (`reg_no`);

--
-- Constraints for table `employee_app_tasktime`
--
ALTER TABLE `employee_app_tasktime`
  ADD CONSTRAINT `employee_app_tasktime_task_id_d13171a8_fk_admin_app_task_id` FOREIGN KEY (`task_id`) REFERENCES `admin_app_task` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
