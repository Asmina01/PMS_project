from django.urls import path

from admin_app.views import *

urlpatterns = [
    path('admin_assigned_projects', admin_assigned_projects, name='admin_assigned_projects'),
    path('assign_task/', assign_task, name='assign_task'),
    path('get-client/', get_client, name='get_client'),

    path('view_progress/', view_progress, name='view_progress'),
    path('view_time_tracking/', view_time_tracking, name='view_time_tracking'),
    path('adminindex', adminindex, name='adminindex'),
    path("base",base,name='base'),
    path('create_project/', create_project, name='create_project'),
    path('add_member/', add_member, name='add_member'),
    path('get_project_members/', get_project_members, name='get_project_members'),
    path('members_list/', members_list, name='members_list'),
path('project_list', project_list, name='project_list'),
path('project_overview/<int:project_id>/', project_overview, name='project_overview'),
path('task_list', task_list, name='task_list'),
    path('delete_member/<str:reg_no>/',delete_member, name='delete_member'),
    path('projects/delete/<int:project_id>/', delete_project, name='delete_project'),
path('progress_page', progress_page, name='progress_page'),
path('backlog_list', backlog_list, name='backlog_list'),
    path('projects/delete/<int:project_id>/',delete_project, name='delete_project'),

    path('sprints_dashboard', sprint_dashboard, name='sprint_dashboard'),
    path('sprint/<int:sprint_id>/', sprint_detail, name='sprint_detail'),

    path('create-sprint/', create_sprint, name='create_sprint'),
    path('add-task-to-sprint/', add_task_to_sprint, name='add_task_to_sprint'),
    path('update-task-status/', update_task_status, name='update_task_status'),
    path("", login, name="login"),



]